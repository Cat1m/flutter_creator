import 'package:flutter/material.dart';
import 'package:sample_flutter/configs/color/color.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback onPressed;
  const InternetExceptionWidget({super.key, required this.onPressed});

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .15),
          const Icon(
            Icons.cloud_off,
            size: 50,
            color: AppColors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                'We’re unable to show results.\nPlease check your data\nconnection.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .15,
          ),
          ElevatedButton(
              onPressed: widget.onPressed,
              child: Center(
                child: Text(
                  'RETRY',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ))
        ],
      ),
    );
  }
}
