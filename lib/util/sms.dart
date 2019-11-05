import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:sms/sms.dart';

class Sms{

  static sendMessage(String sms, String contact,BuildContext context){
  
    SmsSender sender =  SmsSender();
    SmsMessage message = SmsMessage(contact,sms);
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
  
      } else if (state == SmsMessageState.Delivered) {
         AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    body: Center(
                        child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("SMS successFully Sent"),
                      ),
                    ),
                
                    btnOkOnPress: () {
                
                    },
                  ).show();
      } else if (state == SmsMessageState.Fail) {
               AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    body: Center(
                        child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("SMS failed"),
                      ),
                    ),
                
                    btnOkOnPress: () {
                
                    },
                  ).show();
      }
    });
    sender.sendSms(message);


               
  }

}