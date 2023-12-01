import 'package:flutter/material.dart';

class TopUpPopup extends StatefulWidget {
  @override
  _TopUpPopupState createState() => _TopUpPopupState();
}

class _TopUpPopupState extends State<TopUpPopup> {
  int _numberOfHammers = 1; // Initial number of hammers to top up

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Top Up Hammers'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Choose the number of hammers to top up:'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (_numberOfHammers > 1) {
                      _numberOfHammers--;
                    }
                  });
                },
              ),
              Text('$_numberOfHammers'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _numberOfHammers++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_numberOfHammers); // Close the dialog after topping up
          },
          child: const Text('Top Up'),
        ),
      ],
    );
  }
}
