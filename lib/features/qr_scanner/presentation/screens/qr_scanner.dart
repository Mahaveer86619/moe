import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildUi(context),
      ),
    );
  }

  Widget _buildUi(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 120,
          height: 120,
        ),
        const SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: theme.colorScheme.surface,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(5),
              width: 250,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                    returnImage: true,
                  ),
                  //* This gives the barcode image and the QR code value
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;

                    if (image != null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: GestureDetector(
                              onTap: () {
                                //* Copy the QR code value to the clipboard
                                Clipboard.setData(
                                  ClipboardData(
                                    text: barcodes.first.rawValue ?? "",
                                  ),
                                );
                              },
                              child: Text(
                                barcodes.first.rawValue ?? "Error Scanning",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            content: Image.memory(
                              image,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 70),
        Text(
          'Scan The QR-Code',
          style: GoogleFonts.roboto(
            fontSize: theme.textTheme.titleLarge!.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Scan the QR code on the bottom of the',
          style: GoogleFonts.roboto(
            fontSize: theme.textTheme.titleSmall!.fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          'Gateways to continue the installation',
          style: GoogleFonts.roboto(
            fontSize: theme.textTheme.titleSmall!.fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
