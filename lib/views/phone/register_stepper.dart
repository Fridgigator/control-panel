import 'dart:developer';

import 'package:control_panel/view_model/phone/register.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';

class RegisterPhoneStepper extends StatelessWidget {
  final String accessToken;
  final bool smallScreen;
  const RegisterPhoneStepper(
      {super.key, required this.accessToken, required this.smallScreen});

  @override
  Widget build(BuildContext context) {
    log("Build");
    final formKey = GlobalKey<FormState>();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => RegisterPhoneViewModel(
                  formKey: formKey, accessToken: accessToken))
        ],
        builder: (context, child) {
          int index = Provider.of<RegisterPhoneViewModel>(context).currentStep;
          Function(String text, Function onDone) onStepTwoCompleted =
              Provider.of<RegisterPhoneViewModel>(context).onStep2Completed;
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: index,
                onStepCancel: Provider.of<RegisterPhoneViewModel>(context)
                    .getOnStepCancel(context),
                onStepContinue: Provider.of<RegisterPhoneViewModel>(context)
                    .getOnStepContinue(),
                steps: <Step>[
                  Step(
                      title: const Text('Phone #'),
                      content: SizedBox(
                          height: 129,
                          child: _FirstStepView(
                            onSaved:
                                Provider.of<RegisterPhoneViewModel>(context)
                                    .onStep1Saved,
                            onChanged:
                                Provider.of<RegisterPhoneViewModel>(context)
                                    .onStep1Changed,
                            formKey: formKey,
                            smallScreen: smallScreen,
                          ))),
                  const Step(
                      title: Text('Send Pin'),
                      content: Center(
                          child: SizedBox(
                              height: 128,
                              width: 128,
                              child: CircularProgressIndicator()))),
                  Step(
                      title: const Text('Verify Pin'),
                      content: Center(
                          child: SizedBox(
                              height: 128,
                              child: PinCodeTextField(
                                  onChanged: (_) {},
                                  onCompleted: (String text) {
                                    debugPrint("text=$text");
                                    onStepTwoCompleted(text, () {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  appContext: context,
                                  length: 6,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                  ),
                                  animationDuration:
                                      const Duration(milliseconds: 100))))),
                  Step(
                    title: const Text('Complete'),
                    content: Center(
                        child: Icon(
                      size: 128,
                      Provider.of<RegisterPhoneViewModel>(context)
                                  .displayIcon ==
                              IconType.ok
                          ? Icons.check
                          : Icons.error,
                      color: Provider.of<RegisterPhoneViewModel>(context)
                                  .displayIcon ==
                              IconType.ok
                          ? Colors.green
                          : Colors.red,
                    )),
                  ),
                ],
              ));
        });
  }
}

class _FirstStepView extends StatelessWidget {
  final Function(PhoneNumber?) onSaved;
  final Function(PhoneNumber) onChanged;
  const _FirstStepView(
      {required this.formKey,
      required this.smallScreen,
      required this.onSaved,
      required this.onChanged});
  final GlobalKey<FormState> formKey;
  final bool smallScreen;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Form(
          key: formKey,
          child: IntlPhoneField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'US',
            onChanged: onChanged,
            onSaved: onSaved,
          ),
        ));
  }
}
