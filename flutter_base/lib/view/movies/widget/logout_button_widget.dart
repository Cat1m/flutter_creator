import 'package:flutter/material.dart';
import 'package:sample_flutter/configs/routes/routes_name.dart';
import 'package:sample_flutter/generated/l10n/app_localizations.dart';
import 'package:sample_flutter/services/storage/local_storage.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LocalStorage localStorage = LocalStorage();
        localStorage.clearValue('token').then((value) {
          localStorage.clearValue('isLogin');
          Navigator.pushNamed(context, RoutesName.login);
        });
      },
      child: Center(
        child: Text(AppLocalizations.of(context).logout),
      ),
    );
  }
}
