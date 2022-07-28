import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/controller/controllers.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weight Task',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.loginController.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Form(
                  key: controller.formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.weightController,
                    validator: (value) => controller.validateWeight(value!),
                    decoration: const InputDecoration(
                      label: Text('Input weight'),
                    ),
                  ),
                ),
                controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          controller.addWeightToFirebase();
                        },
                        child: const Text('Add new weight'),
                      ),
                Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.weights.length,
                    itemBuilder: (context, index) {
                      var weight = controller.weights[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(weight.weight),
                          IconButton(
                            onPressed: () {
                              controller.deleteWeight(weight.id!);
                            },
                            icon: Icon(
                              Icons.delete,
                            ),
                          )
                        ],
                      );
                    },
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
