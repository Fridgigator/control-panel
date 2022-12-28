import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:control_panel/view_model/phone/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  formKey: formKey,
                  accessToken: accessToken,
                  pop: (String display) {
                    FlushbarHelper.createError(message: display).show(context);
                  }))
        ],
        builder: (context, child) {
          Function(String text, Function onDone,
                  Function(String) displaySnackbar) onStepTwoCompleted =
              Provider.of<RegisterPhoneViewModel>(context).onStep2Completed;
          Function onStep1Changed =
              Provider.of<RegisterPhoneViewModel>(context).onStep1Changed;

          int index = Provider.of<RegisterPhoneViewModel>(context).currentStep;
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: index,
                onStepCancel: Provider.of<RegisterPhoneViewModel>(context)
                    .getOnStepCancel(context),
                onStepContinue: Provider.of<RegisterPhoneViewModel>(context)
                    .getOnStepContinue((String display) {
                  FlushbarHelper.createError(message: display).show(context);
                }),
                steps: <Step>[
                  Step(
                      title: const Text('Phone #'),
                      content: SizedBox(
                          child: _FirstStepView(
                        removePhone: (String phoneName) {
                          Provider.of<RegisterPhoneViewModel>(context,
                                  listen: false)
                              .removePhone(phoneName, (String display) {
                            FlushbarHelper.createError(message: display)
                                .show(context);
                          });
                        },
                        registeredTelephones:
                            Provider.of<RegisterPhoneViewModel>(context)
                                .registeredTelephones,
                        onSaved: Provider.of<RegisterPhoneViewModel>(context)
                            .onStep1Saved,
                        onChanged: (PhoneNumber p) {
                          onStep1Changed(p, (String display) {
                            FlushbarHelper.createError(message: display)
                                .show(context);
                          });
                        },
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
                                    }, (String display) {
                                      FlushbarHelper.createError(
                                              message: display)
                                          .show(context);
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
  final Function(String) removePhone;
  final List<String>? registeredTelephones;
  const _FirstStepView(
      {required this.formKey,
      required this.smallScreen,
      required this.onSaved,
      required this.registeredTelephones,
      required this.onChanged,
      required this.removePhone});
  final GlobalKey<FormState> formKey;
  final bool smallScreen;
  @override
  Widget build(BuildContext context) {
    List<Widget>? oldPhones = registeredTelephones?.map((e) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: Text(e),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            child: IconButton(
                onPressed: () {
                  removePhone(e);
                },
                icon: const Icon(FontAwesomeIcons.trash)),
          )
        ],
      );
    }).toList();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
              surfaceTintColor: Colors.greenAccent,
              child: Column(children: [
                if (oldPhones != null) ...oldPhones,
                if (oldPhones == null)
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: LinearProgressIndicator()),
              ])),
          Card(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
