import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/controller/controllers.dart';
import 'package:weight_tracker/model/weight_model.dart';

class HomeController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController weightController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<WeightModel> weights = RxList<WeightModel>([]);
  late User user;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection('Weights');
    user = Get.arguments;
    weights.bindStream(getAllWeights());
  }

  @override
  void onClose() {
    super.onClose();
    weightController.dispose();
  }

  validateWeight(String value) {
    if (value.isEmpty) {
      return 'Weight is needed.';
    }
    return null;
  }

  addWeightToFirebase() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    collectionReference.add({
      'weight': weightController.text,
      'date': DateTime.now(),
      'user_id': user.uid,
    }).whenComplete(() {
      weightController.clear();
      Get.snackbar(
        'Weight',
        'Weight is added successfuly.',
        colorText: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 40) +
            const EdgeInsets.symmetric(horizontal: 16),
      );
    }).catchError((error) {
      Get.snackbar(
        'Something went error',
        error.toString(),
        colorText: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 40) +
            const EdgeInsets.symmetric(horizontal: 16),
      );
    });
  }

  Stream<List<WeightModel>> getAllWeights() {
    return collectionReference
        .orderBy('date', descending: true)
        .snapshots()
        .map((query) =>
            query.docs.map((item) => WeightModel.fromMap(item)).toList());
  }

  deleteWeight(String id) {
    collectionReference.doc(id).delete().whenComplete(() {
      Get.snackbar(
        'Weight',
        'Weight is removed successfuly.',
        colorText: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 40) +
            const EdgeInsets.symmetric(horizontal: 16),
      );
    });
  }
}
