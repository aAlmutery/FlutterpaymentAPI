import 'package:flutter/material.dart';
import 'package:payment_test/Controllers/payment_controller.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    buttonSpinner() {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(30.0),
          // ),
        ),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Center(
          child: Text(
            'Payment Form',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                // const Text(
                //   'My Form',
                //   style: TextStyle(
                //     fontSize: 33,
                //     color: Colors.black54,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25,
                    left: 25,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: paymentController.cardNum,
                          decoration: const InputDecoration(
                            labelText: 'Card Number',
                            helperText: '0000 0000 0000 0000',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Correct Card Number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: paymentController.cardDate,
                          decoration: const InputDecoration(
                            labelText: 'Card Expiry Date',
                            helperText: '(05/25 Or 05-25)',
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Card Expiry Date';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: paymentController.cardCode,
                          decoration: const InputDecoration(
                            labelText: 'Security Code',
                            helperText: '3 Degit number',
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Security Code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        Obx(
                          () => paymentController.isSaveing.value == true
                              ? buttonSpinner()
                              : ElevatedButton(
                                  child: const Text('Pay Now'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      paymentController.savePayment(context);
                                    }
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
