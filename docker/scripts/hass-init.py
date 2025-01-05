"""Script to manage users for the Home Assistant auth provider."""

import argparse
import asyncio
from collections.abc import Sequence
from datetime import timedelta
import json
import logging
import os
import string
import random
from typing import TYPE_CHECKING

from homeassistant import (runner, loader)
from homeassistant.auth import auth_manager_from_config
from homeassistant.auth.providers import homeassistant as hass_auth
from homeassistant.auth.const import GROUP_ID_ADMIN
from homeassistant.auth.models import TOKEN_TYPE_LONG_LIVED_ACCESS_TOKEN
from homeassistant.config import get_default_config_dir
from homeassistant.config_entries import ConfigEntries
from homeassistant.setup import async_setup_component
from homeassistant.components.person import async_create_person
from homeassistant.util.async_ import create_eager_task
from homeassistant.core import HomeAssistant
from homeassistant.helpers import (
    area_registry as ar,
    device_registry as dr,
    entity_registry as er,
    issue_registry as ir,
)
from homeassistant.helpers.translation import async_get_translations
from homeassistant.helpers.check_config import async_check_ha_config_file
from homeassistant.components.onboarding import (
    DOMAIN as ONBOARDING_DOMAIN,
    STEPS,
    STORAGE_KEY,
    STORAGE_VERSION,
    OnboardingData,
    OnboardingStorage,
)
from homeassistant.util.unit_system import METRIC_SYSTEM
DEFAULT_AREAS = ("living_room", "kitchen", "bedroom")

# mypy: allow-untyped-calls, allow-untyped-defs


def run(args: Sequence[str] | None) -> None:
    """Init home assistant with onboarded admin user"""
    parser = argparse.ArgumentParser(description="Init Home Assistant")
    parser.add_argument(
        "-c",
        "--config",
        default=get_default_config_dir(),
        help="Directory that contains the Home Assistant configuration",
    )
    parser.add_argument("-u", "--username", help="Admin username")
    parser.add_argument("-p", "--password", help="Admin password")
    parser.set_defaults(func=init_hass)
    

    # parser_add = subparsers.add_parser("add")
    # parser_add.add_argument("username", type=str)
    # parser_add.add_argument("password", type=str)
    # parser_add.set_defaults(func=add_user)

    asyncio.set_event_loop_policy(runner.HassEventLoopPolicy(False))
    asyncio.run(run_command(parser.parse_args(args)))


async def run_command(args: argparse.Namespace) -> None:
    """Run the command."""      
    hass = HomeAssistant(os.path.join(os.getcwd(), args.config))
    loader.async_setup(hass)
    
    # Load essential registries: area, device, entity, and issue registries
    # These are required for proper Home Assistant initialization
    await asyncio.gather(
        async_check_ha_config_file(hass),
        ar.async_load(hass),
        dr.async_load(hass),
        er.async_load(hass),
        ir.async_load(hass, read_only=True),
    )
    
    hass.auth = await auth_manager_from_config(hass, [{"type": "homeassistant"}], [])
    provider = hass.auth.auth_providers[0]
    await provider.async_initialize()
    
    await args.func(hass, provider, args)

    # Triggers save on used storage helpers with delay (core auth)
    logging.getLogger("homeassistant.core").setLevel(logging.WARNING)

    await hass.async_stop()


async def init_hass(
    hass: HomeAssistant, provider: hass_auth.HassAuthProvider, args: argparse.Namespace
) -> None:
    """Initialize Home Assistance."""
   
    user, credentials, username, password = await _create_admin_user(hass, provider, args)
    access_token = await create_and_verify_token(hass, provider, user, credentials)
    
     # Print result as JSON
    result = {
        "access_token": access_token,
        "username": username,
        "password": password
    }
    print(json.dumps(result))
    
    # Complete onboarding
    await _setup_onboarding(hass)
    
    # Set up location configuration including timezone, coordinates, and unit system
    await _setup_location_config(hass)
    
    # Create default areas using translations
    # await _create_default_areas(hass)
    
    # Initialize analytics and integrations
    await _initialize_analytics(hass)
    

async def _create_admin_user(hass: HomeAssistant, provider: hass_auth.HassAuthProvider, args: argparse.Namespace):
    """Set up authentication and create admin user."""
    
    if hasattr(args, 'username') and hasattr(args, 'password') and args.username and args.password:
        username = args.username
        password = args.password
    else:
        username = "".join(random.choice(string.ascii_lowercase) for i in range(10))
        password = "".join(random.choice(string.ascii_lowercase) for i in range(15))

    # Create admin user
    user = await hass.auth.async_create_user(
        name=username,
        group_ids=[GROUP_ID_ADMIN]
    )

    # Add credentials and link to user
    try:
        # provider.data.add_auth(args.username, args.password)
        await provider.async_add_auth(username, password)
    except hass_auth.InvalidUser:
        print("Username already exists!")
        return
    
    
    credentials = await provider.async_get_or_create_credentials(
        {"username": username}
    )
    await hass.auth.async_link_user(user, credentials)

    # Create person associated with the user
    if "person" in hass.config.components:
        await async_create_person(hass, name=username, user_id=user.id)

    # Store the data
    await provider.data.async_save()
    # await hass.auth._store._store.async_save(hass.auth._store._data_to_save())

    return user, credentials, username, password

async def create_and_verify_token(hass: HomeAssistant, provider, user, credentials):
    """Create and verify token persistence."""
    # Create refresh token
    refresh_token = await hass.auth.async_create_refresh_token(
        user,
        token_type=TOKEN_TYPE_LONG_LIVED_ACCESS_TOKEN,
        client_name="hass-init.py",
        client_icon="mdi:robot",
        credential=credentials,
        access_token_expiration=timedelta(days=3650)
    )

    # Create access token
    access_token = hass.auth.async_create_access_token(refresh_token)

    # Force save auth data
    # await provider.data.async_save()
    await hass.auth._store._store.async_save(hass.auth._store._data_to_save())

    # Verify token exists in storage
    if not any(token.id == refresh_token.id for token in user.refresh_tokens.values()):
        raise Exception("Token not properly stored")

    return access_token


# There is a BUG! Areas store is not save data.
async def _create_default_areas(hass: HomeAssistant):
    """Create default areas with translations."""
    
    translations = await async_get_translations(
        hass, "en", "area", {ONBOARDING_DOMAIN}
    )

    area_registry = ar.async_get(hass)

    for area in DEFAULT_AREAS:
        name = translations[f"component.onboarding.area.{area}"]
        # Guard because area might have been created by an automatically
        # set up integration.
        if not area_registry.async_get_area_by_name(name):
            area_registry.async_create(name)

async def _initialize_analytics(hass: HomeAssistant):
    """Initialize analytics and default integrations."""
    
    # Initialize config entries
    if not hasattr(hass, 'config_entries') or hass.config_entries is None:
        hass.config_entries = ConfigEntries(hass, {})
        await hass.config_entries.async_initialize()
    
    onboard_integrations = [
        "google_translate",
        "met",
        "radio_browser",
        "shopping_list",
    ]

    # Start configuration flows for the integrations
    coros = [
        hass.config_entries.flow.async_init(
            domain, context={"source": "onboarding"}
        )
        for domain in onboard_integrations
    ]

    # await async_setup_component(hass, 'config', {})
    # await hass.async_block_till_done()

    # Ensure analytics component is set up
    if "analytics" not in hass.config.components:
        coros.append(async_setup_component(hass, "analytics", {}))

    # Run all setup coroutines
    await asyncio.gather(*(create_eager_task(coro) for coro in coros))

async def _setup_onboarding(hass: HomeAssistant):
    """Set up and save onboarding data."""
    # Mark onboarding steps as done
    onboarding_data = OnboardingData(
        listeners=[],
        onboarded=True,
        steps={"done": STEPS}
    )
    hass.data[ONBOARDING_DOMAIN] = onboarding_data

    # Save onboarding data
    store = OnboardingStorage(hass, STORAGE_VERSION, STORAGE_KEY, private=True)
    if (data := await store.async_load()) is None:
        data = {"done": []}
    data["done"].append(STEPS)

    await store.async_save(onboarding_data.steps)

async def _setup_location_config(hass: HomeAssistant):
    """Set up location configuration."""
    location_config = {
        "latitude": 50.4501,
        "longitude": 30.5234,
        "elevation": 179,
        "unit_system": METRIC_SYSTEM,
        "location_name": "Test home",
        "currency": "UAH",
        "country": "UA",
        "time_zone": "Europe/Kyiv",
    }
    await hass.config.async_update(**location_config)

if __name__ == "__main__":
    run(None)
