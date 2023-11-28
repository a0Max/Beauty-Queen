import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart';

class ErrorPopUp extends StatelessWidget {
  final String message;
  final String? title;

  const ErrorPopUp({Key? key, required this.message, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? 'error'),
      content: Column(
        children: <Widget>[
          const SizedBox(height: 24.0),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 36.0),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.16),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ]),
              child: Text(
                'تم',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
