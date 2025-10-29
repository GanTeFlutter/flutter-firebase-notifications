import 'package:flutter/material.dart';
import 'package:flutter_base_start/future/splash/cubit/version_control_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VersionControlCubit, VersionControlState>(
        listener: (context, state) {
          if (state is VersionControlLoaded) {
            context.goNamed('HomeView');
          } else if (state is VersionControlError) {
            context.goNamed('VersionUpdate');
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
