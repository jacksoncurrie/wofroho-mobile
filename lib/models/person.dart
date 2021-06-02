import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;

class Person {
  Person({
    this.id,
    this.imageUrl,
    required this.name,
    required this.role,
    this.datesFromHome,
    this.organisation,
    this.isUser,
    this.image,
  });

  Person.fromFirebase(Map<String, dynamic> data, String personId, bool isUser) {
    id = personId;
    imageUrl = data['imageUrl'];
    name = data['name'];
    role = data['role'];
    organisation = data['organisation'];
    downloadUrl = data['downloadUrl'];
    final list = data['datesFromHome'] as List<dynamic>?;
    final timestamps = list?.map((i) => i as Timestamp).toList();
    datesFromHome = timestamps?.map((i) => i.toDate()).toList();
    this.isUser = isUser;
  }

  String? id;
  String? imageUrl;
  String? name;
  String? role;
  List<DateTime>? datesFromHome;
  String? organisation;
  bool? isUser;
  File? image;
  String? downloadUrl;

  Future addToFirebase() async {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;
    var userId = auth.currentUser!.uid;

    var data = {
      'name': name,
      'role': role,
    };

    var documentReference = firestore.collection('users').doc(userId);

    if (image != null) {
      final fileExtension = p.extension(image!.path);
      final imageUrlStored = 'user_images/$userId$fileExtension';
      data['imageUrl'] = imageUrlStored;
      // Upload profile image
      await firebase_storage.uploadImage(imageUrlStored, image!);
      downloadUrl = await firebase_storage.getImage(imageUrlStored);
      data['downloadUrl'] = downloadUrl;
    }

    await firestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        data,
      );
    });
  }

  Future editInFirebase() async {
    if (id == null) return;
    var firestore = FirebaseFirestore.instance;

    var data = {
      'name': name,
      'role': role,
      'datesFromHome': datesFromHome,
      'organisation': organisation,
    };

    var documentReference = firestore.collection('users').doc(id);

    if (image != null) {
      // Delete old image
      if (imageUrl != null) await firebase_storage.deleteImage(imageUrl!);

      final fileExtension = p.extension(image!.path);
      final imageUrlStored =
          'user_images/${documentReference.id}$fileExtension';
      data['imageUrl'] = imageUrlStored;
      // Upload profile image
      await firebase_storage.uploadImage(imageUrlStored, image!);
      downloadUrl = await firebase_storage.getImage(imageUrlStored);
      data['downloadUrl'] = downloadUrl;
    }

    await firestore.runTransaction((transaction) async {
      transaction.update(
        documentReference,
        data,
      );
    });
  }

  Future deleteFromFirebase() async {
    if (id == null) return;
    var firestore = FirebaseFirestore.instance;

    var documentReference = firestore.collection('users').doc(id);

    // Delete old image
    if (imageUrl != null) await firebase_storage.deleteImage(imageUrl!);

    await firestore.runTransaction((transaction) async {
      transaction.delete(documentReference);
    });
  }
}
