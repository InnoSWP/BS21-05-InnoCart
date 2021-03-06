import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

Future<void> pushFirebaseStorage(
    int id, PlatformFile? pickedFile, int userId) async {
  File file;
  if (pickedFile != null) {
    file = File(pickedFile.path!);
    FirebaseStorage.instance.ref().child('files/${id}').putFile(file);
    FirebaseFirestore data = FirebaseFirestore.instance;
    data
        .collection('ticket_data')
        .doc('$id')
        .set({'firePath': 'files/${id}', 'user_id': userId});
  }
}

Future<void> pushAvatarFirebaseStorage(
    PlatformFile? pickedFile, int userId) async {
  File file;
  if (pickedFile != null) {
    file = File(pickedFile.path!);
    FirebaseStorage.instance.ref().child('avatars/${userId}').putFile(file);
    FirebaseFirestore data = FirebaseFirestore.instance;
    data
        .collection('user_data')
        .doc('$userId')
        .set({'firePath': 'avatars/${userId}', 'user_id': userId});
  }
}

Future<bool> ticketExists(int ticketId) async {
  dynamic cur_doc = await FirebaseFirestore.instance
      .collection('ticket_data')
      .doc('$ticketId')
      .get();
  return cur_doc.exists;
}

Future<String> getUrlByTicketId(int ticketId) async{
  return await FirebaseStorage.instance.ref().child("files/$ticketId").getDownloadURL();

}

Future<bool> userExists(int userId) async {
  dynamic cur_doc = await FirebaseFirestore.instance
      .collection('user_data')
      .doc('$userId')
      .get();
  return cur_doc.exists;
}

Future<String> getUrlByUserId(int userId) async{
  return await FirebaseStorage.instance.ref().child("avatars/$userId").getDownloadURL();
}