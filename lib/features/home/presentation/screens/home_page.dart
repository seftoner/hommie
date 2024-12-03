import 'package:flutter/material.dart';
import 'package:hommie/features/areas/application/areas_controller.dart';
import 'package:hommie/ui/styles/spacings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var areas = ref.watch(areasControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hommie')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            const Text("There's nothing much you can do, here"),
            $h24,
            const Text('List of areas:'),
            SizedBox(
              height: 300,
              child: areas.when(
                data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(data[index].name),
                        )),
                error: (error, stack) =>
                    Text('Oops, something unexpected happened \n $error'),
                loading: () => CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
