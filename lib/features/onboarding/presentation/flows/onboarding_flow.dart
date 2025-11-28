import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:hommie/features/auth/presentation/flows/add_server_flow.dart';
import 'package:hommie/features/onboarding/presentation/screens/permissions_page.dart';
import 'package:hommie/features/onboarding/presentation/screens/welcome_page.dart';

/// Steps that compose the onboarding flow.
enum OnboardingStep { welcomeOne, permissions, addServer }

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  late final FlowController<OnboardingStep> controller;

  @override
  void initState() {
    super.initState();
    controller = FlowController(OnboardingStep.welcomeOne);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<OnboardingStep>(
      controller: controller,
      onGeneratePages: (step, pages) => [
        MaterialPage<void>(
          child: WelcomePage(
            onContinue: () {
              controller.update((_) => OnboardingStep.permissions);
            },
          ),
        ),
        if (step == OnboardingStep.permissions ||
            step == OnboardingStep.addServer)
          MaterialPage<void>(
            child: PermissionsPage(
              onConnect: () {
                controller.update((_) => OnboardingStep.addServer);
              },
            ),
          ),

        if (step == OnboardingStep.addServer)
          const MaterialPage(
            child: PopScope(
              canPop: false,
              child: AddServerFlow(userCanCancel: false),
            ),
          ),
      ],
    );
  }
}
