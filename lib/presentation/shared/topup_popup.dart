import 'package:flutter/material.dart';
import 'package:noel/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TopUpPopup extends StatefulWidget {
  const TopUpPopup({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
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
                    child: Image.asset('assets/mobile/topup_text.png',
                        height: 40)),
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/home/bua4x.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                Positioned(
                    top: 200,
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
                              border:
                                  Border.all(color: Colors.white, width: 1)),
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
                                    shape: BoxShape.circle,
                                    color: primaryColor),
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
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_numberOfHammers);
              },
              child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'TopUp',
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class ConfirmPopUp extends StatefulWidget {
  const ConfirmPopUp({super.key, required this.number});

  final int number;

  @override
  _ConfirmPopUpState createState() => _ConfirmPopUpState();
}

class _ConfirmPopUpState extends State<ConfirmPopUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                              'We have successfully recorded your transaction for the purchase of ${widget.number.toString()} hammers.',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          width: 320,
                          child: Text(
                              'With each hammer you buy, you have contributed 5,000 VND to the OTSV charity fund.\n\nYou can contribute directly here, or we will send you a statement at the end of the program',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextButton(
                            onPressed: () {
                              launchUrl(Uri(
                                  scheme: 'https',
                                  host: 'page.momoapp.vn',
                                  path: '/SsWKrH3512c'));
                            },
                            child: const Text('Momo Link',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)))
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Close',
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
