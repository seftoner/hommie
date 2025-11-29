import 'package:flutter/material.dart';

class AvailableSeversListTitle extends StatelessWidget {
  const AvailableSeversListTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Available home assistant servers',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        const CircularProgressIndicator.adaptive()
      ],
    );
  }
}
