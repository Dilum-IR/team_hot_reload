import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRScannerAndGenerator extends StatefulWidget {
  const QRScannerAndGenerator({super.key});

  @override
  State<QRScannerAndGenerator> createState() => _QRScannerAndGeneratorState();
}

class _QRScannerAndGeneratorState extends State<QRScannerAndGenerator> {
  String? qrData;
  Uint8List? image;
  String? barcodes;

  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScanCompleted = false;

  @override
  Widget build(BuildContext context) {
    MobileScannerController controller = MobileScannerController(
      // detectionSpeed: DetectionSpeed.,
      facing: isFrontCamera ? CameraFacing.front : CameraFacing.back,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        leading: IconButton(
          style: const ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size.square(30)),
            backgroundColor: MaterialStatePropertyAll(Colors.white70),
          ),
          onPressed: () {},
          icon: const Icon(Icons.qr_code_scanner_rounded),
        ),
        title: const Text("QR Scanner"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              controller.toggleTorch();
            },
            icon: Icon(
              Icons.flash_on,
              color: isFlashOn ? Colors.white : Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFrontCamera = !isFrontCamera;
              });
              controller.switchCamera();
            },
            icon: Icon(
              Icons.flip_camera_android_rounded,
              color: isFrontCamera ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Scan QR Code",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: MobileScanner(
                      // allowDuplicates: true,
                      fit: BoxFit.cover,
                      controller: controller,
                      onDetect: (capture, args) {
                        if (!isScanCompleted) {
                          setState(() {
                            barcodes = capture.rawValue;
                            isScanCompleted = true;
                          });
                        } else {
                          return;
                        }
                        if (isScanCompleted) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                // image = null;
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Text(barcodes ?? "---"),
                                      ElevatedButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                                text: barcodes ?? "---"),
                                          );
                                        },
                                        child: const Text("Copy"),
                                      )
                                    ],
                                  ),
                                  content: SizedBox(
                                    height: 310,
                                    child: Column(
                                      children: [
                                        PrettyQrView.data(
                                            data: barcodes ?? "---"),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            if (mounted) {
                                              setState(() {
                                                isScanCompleted = false;
                                              });
                                            }
                                          },
                                          child: const Text("Close"),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Scan QR Genarator",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onSubmitted: (value) {
                  setState(() {
                    qrData = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              if (qrData != null)
                Center(
                  child: SizedBox(
                      height: 300,
                      width: 300,
                      child: PrettyQrView.data(data: qrData!)),
                )
            ],
          ),
        ),
      ),
    );
  }
}
