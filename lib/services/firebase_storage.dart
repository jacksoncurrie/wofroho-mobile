import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const _usersCollectionName = 'users';
const usersImageFieldName = 'profileImageUrl';
const _eventsCollectionName = 'events';
const eventImageFieldName = 'imageUrl';

Future uploadImage(String imagePath, File file) async {
  try {
    await FirebaseStorage.instance.ref(imagePath).putFile(file);
  } on FirebaseException catch (e) {
    log(e.message!);
  }
}

Future<String?> getImage(String imageUrl) async {
  try {
    final downloadURL =
        await FirebaseStorage.instance.ref(imageUrl).getDownloadURL();
    return downloadURL;
  } on FirebaseException catch (e) {
    log(e.message!);
    return null;
  }
}

Future deleteImage(String imagePath) async {
  try {
    await FirebaseStorage.instance.ref(imagePath).delete();
  } on FirebaseException catch (e) {
    log(e.message!);
  }
}

Future addUserImageToFirestore(String userId, String imageUrl) async {
  try {
    await FirebaseFirestore.instance
        .collection(_usersCollectionName)
        .doc(userId)
        .update({usersImageFieldName: imageUrl});
  } on FirebaseException catch (e) {
    log(e.message!);
  }
}

Future addEventImageToFirestore(String eventId, String imageUrl) async {
  try {
    await FirebaseFirestore.instance
        .collection(_eventsCollectionName)
        .doc(eventId)
        .update({eventImageFieldName: imageUrl});
  } on FirebaseException catch (e) {
    log(e.message!);
  }
}

Future<String?> getImageUrlForUser(String userId) async {
  try {
    final usersDetails = await FirebaseFirestore.instance
        .collection(_usersCollectionName)
        .doc(userId)
        .get();
    return usersDetails.data()![usersImageFieldName];
  } on FirebaseException catch (e) {
    log(e.message!);
    return null;
  }
}

Future<String?> getImageUrlForEvent(String eventId) async {
  try {
    final usersDetails = await FirebaseFirestore.instance
        .collection(_eventsCollectionName)
        .doc(eventId)
        .get();
    return usersDetails.data()![eventImageFieldName];
  } on FirebaseException catch (e) {
    log(e.message!);
    return null;
  }
}
