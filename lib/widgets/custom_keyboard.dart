import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';


class CustomKeyboard extends StatelessWidget {
  CustomKeyboard(
      {Key? key, this.isSecure = false, required this.onDone, this.onChange})
      : super(key: key);

  bool isSecure;
  Function(String) onDone;
  Function(String)? onChange;

  List<int> keys = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  String value = '';

  @override
  Widget build(BuildContext context) {
    if (isSecure) keys.shuffle();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              keys[0],
            ),
            _buildButton(
              keys[1],
            ),
            _buildButton(
              keys[2],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              keys[3],
            ),
            _buildButton(
              keys[4],
            ),
            _buildButton(
              keys[5],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              keys[6],
            ),
            _buildButton(
              keys[7],
            ),
            _buildButton(
              keys[8],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              'clear',
            ),
            _buildButton(
              keys[9],
            ),
            _buildButton(
              'done',
            ),
          ],
        )
      ],
    );
  }

  _buildButton(
    var name,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (name is int) {
            if (value.length < 4) {
              value += '$name';
              onChange!(value);
            }
          } else if (name == 'clear') {
            if (value.isNotEmpty) {
              value = value.substring(0, value.length - 1);
              onChange!(value);
            }
          } else {
            // all done need check
            if (value.length == 4) {
              onDone(value);
            } else {
              //show toast
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: name is int
              ? Text(
                  '$name',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                )
              : name == 'clear'
                  ? const Icon(
                      Icons.backspace,
                    )
                  : const Icon(
                      Icons.done,
                      color: secondaryButtonColor,
                    ),
        ),
      ),
    );
  }
}
