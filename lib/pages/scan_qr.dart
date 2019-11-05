import 'package:api_app/util/api.dart';
import 'package:api_app/util/scanqr.dart';
import 'package:api_app/util/sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../api_service.dart';

class ScanQr extends StatefulWidget {
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () async {
            Api api = Api();
            String qr = await scanQR();
            if (!mounted) {
              return;
            } else {
              Student st = await api.getStudentbyId(int.parse(qr));
              Sms.sendMessage("${st.name} is Entering the school", st.contact, context);
            }
          },
          child: Image(
            width: 200,
            height: 200,
            image: AssetImage("assets/images/qr-code.png"),
          ),
        ),
      ),
    );
  }
}
