import 'package:flutter/material.dart';
import '../functions/show_custom_messenger.dart';

class CustomMessenger extends StatelessWidget {
  const CustomMessenger({Key? key, required this.state, required this.content}) : super(key: key);
  final CustomMessengerState state;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.1),
                ),
              ],
              border: Border.all(
                color: state.getColor(),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: state.getColor(),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Icon(state.getIcon(), color: state.getIconColor(), size: 32),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          content,
                          style: TextStyle(color: state.getTextColor(), fontWeight: FontWeight.w400, fontSize: 16),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: Container(
                decoration: BoxDecoration(
                    color: state.getColor(), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
