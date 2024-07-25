import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payment_test/messages.dart';

import 'package:xml2json/xml2json.dart';

class PaymentController extends GetxController {
  RxBool isSaveing = false.obs;

  TextEditingController cardNum = TextEditingController();
  TextEditingController cardDate = TextEditingController();
  TextEditingController cardCode = TextEditingController();

  Future<void> savePayment(context) async {
    isSaveing(true);
    final Xml2Json xml2json = Xml2Json();

    const headers = {
      'Content-Type': 'text/xml',
      'Accept': '*/*',
    };

    var url = Uri.parse('https://pgw.alsaqi.net/fim/api');

    var xMLbody = ''' 
      <CC5Request>
          <Name>hasadmin</Name>
          <Password>TEMP72151457</Password>
          <ClientId>340000006</ClientId>
          <Type>Auth</Type>
          <Currency>368</Currency>

          <Total>15</Total>
          <Number>${cardNum.text}</Number>
          <Expires>${cardDate.text}</Expires>
          <Cvv2Val>${cardCode.text}</Cvv2Val>
      </CC5Request>
    ''';

    http.Response response = await http.post(
      url,
      headers: headers,
      body: xMLbody,
    );

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsonResponse = xml2json.toGData();
      var responseData = json.decode(jsonResponse);

      var responseCode = responseData['CC5Response']['ProcReturnCode']['\$t'];
      var responseMessage = responseData['CC5Response']['Response']['\$t'];
      var responseErrorMessage = responseData['CC5Response']['ErrMsg']['\$t'];

      if (responseCode.toString() == '00') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Messages(
              message: responseMessage,
            ),
          ),
        );
      } else {
        if (responseErrorMessage == 'Do not honour') {
          responseErrorMessage =
              'Expiry Date Or Card Security Code Is not valid';
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Messages(
                message: responseMessage,
                errorMessage: responseErrorMessage,
              ),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Messages(
                message: responseMessage,
                errorMessage: responseErrorMessage,
              ),
            ),
          );
        }
      }
    }

    isSaveing(false);
  }
}
