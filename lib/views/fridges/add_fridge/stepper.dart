
import 'package:control_panel/view_model/main_view/fridges/add_fridge_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStepper extends StatelessWidget {
  final String accessToken;
  const AddStepper({super.key, required this.accessToken});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) =>
                  StepperViewModel(formKey: formKey, accessToken: accessToken))
        ],
        builder: (context, child) {
          int index = Provider.of<StepperViewModel>(context).currentStep;
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: index,
                onStepCancel: Provider.of<StepperViewModel>(context)
                    .getOnStepCancel(context),
                onStepContinue: Provider.of<StepperViewModel>(context)
                    .getOnStepContinue(context),
                steps: <Step>[
                  Step(
                      title: const Text('Name'),
                      content: SizedBox(
                          height: 64, child: _FirstStepView(formKey: formKey))),
                  const Step(
                    title: Text('Verify'),
                    content: Center(
                        child: SizedBox(
                            height: 64,
                            width: 64,
                            child: CircularProgressIndicator())),
                  ),
                  Step(
                    title: const Text('Complete'),
                    content: Center(
                        child: Icon(
                      size: 64,
                      Provider.of<StepperViewModel>(context).displayIcon ==
                              IconType.ok
                          ? Icons.check
                          : Icons.error,
                      color:
                          Provider.of<StepperViewModel>(context).displayIcon ==
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
  const _FirstStepView({required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Form(
        key: formKey,
        child: Column(children: [
          TextFormField(
            onSaved: Provider.of<StepperViewModel>(context).onSave,
            decoration: const InputDecoration(hintText: "Fridge name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              if (value.length > 64) {
                return 'Name should be less than 64 characters';
              }
              return null;
            },
          ),
        ]),
      ),
    );
  }
}
