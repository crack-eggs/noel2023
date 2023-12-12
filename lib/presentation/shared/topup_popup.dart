import 'package:flutter/material.dart';
import 'package:noel/constants.dart';

class TopUpPopup extends StatefulWidget {
  @override
  _TopUpPopupState createState() => _TopUpPopupState();
}

class _TopUpPopupState extends State<TopUpPopup> {
  int _numberOfHammers = 1; // Initial number of hammers to top up

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
            clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 0),
              child: Image.asset(
                'assets/mobile/popup.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
                top: 80,
                left: 40,
                child: Image.asset('assets/mobile/topup_text.png', height: 40)),
            Positioned(
              top: 140,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/home/bua4x.png',
                width: 60,
                height: 60,
              ),
            ),
            Positioned(
                top: 210,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_numberOfHammers > 1) {
                                  _numberOfHammers--;
                                }
                              });
                            },
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                '$_numberOfHammers',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _numberOfHammers++;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
              left: 0,
              bottom: -40,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('TopUp'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
