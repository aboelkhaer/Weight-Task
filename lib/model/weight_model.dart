import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  String? id;
  late String weight;
  late Timestamp date;
  late String userId;
  WeightModel({
    required this.weight,
    required this.date,
    required this.userId,
  });

  WeightModel.fromMap(DocumentSnapshot data) {
    userId = data['user_id'];
    weight = data['weight'];
    id = data.id;
    date = data['date'];
  }
}
