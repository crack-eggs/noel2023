import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePopup extends StatelessWidget {
  final String qrCodeData;

  const QrCodePopup({required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data: qrCodeData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 16.0),
            const Text("Scan this QR code with your phone"),
          ],
        ),
      ),
    );
  }
}

// Trong hàm để hiển thị popup QR code
void showQrCodePopup(BuildContext context, String qrCodeData) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return QrCodePopup(qrCodeData: qrCodeData);
    },
  );
}
