import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:sample_flutter/configs/routes/routes_name.dart';
import 'package:sample_flutter/utils/extensions/flush_bar_extension.dart';

import '../../../utils/extensions/enums.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.formKey});
  final dynamic formKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (current, previous) =>
          current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          context.flushBarErrorMessage(message: state.message.toString());
        }
        if (state.postApiStatus == PostApiStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
        builder: (context, state) {
          return ElevatedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  context.read<LoginBloc>().add(LoginApi());
                }
              },
              child: state.postApiStatus == PostApiStatus.loading
                  ? const CircularProgressIndicator()
                  : const Text('Login'));
        },
      ),
    );
  }
}
