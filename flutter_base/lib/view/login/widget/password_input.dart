import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:sample_flutter/generated/l10n/app_localizations.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText: AppLocalizations.of(context)
                .passwordShouldbeatleast_characterswithatleastoneletterandnumber,
            helperMaxLines: 2,
            labelText: AppLocalizations.of(context).password,
            errorMaxLines: 2,
          ),
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter password';
            }
            if (value.length < 6) {
              return 'Please enter password greater than six characters';
            }
            return null;
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
