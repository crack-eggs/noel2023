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
            Container(
              margin: const EdgeInsets.only(left: 16, right: 0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/mobile/popup.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Image.asset('assets/mobile/topup_text.png', width: 200),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/home/bua4x.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
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
                                  padding: const EdgeInsets.all(8),
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
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
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
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/mobile/popup.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
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
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 8),
                      child: const Text(
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
                                fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
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
