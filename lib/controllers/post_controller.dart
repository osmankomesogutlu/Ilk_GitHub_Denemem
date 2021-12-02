import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_guncelleme/constants/firebase.dart';
import 'package:firebase_guncelleme/helpers/show_loading.dart';
import 'package:firebase_guncelleme/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();
  Rx<PostModel> postModel =
      PostModel(id: '', description: '', imageUrl: '').obs;
  String postCollection = 'posts';
  String imageUrl =
      "https://cdn.pixabay.com/photo/2015/06/19/21/24/avenue-815297_960_720.jpg";
  TextEditingController id = TextEditingController();
  TextEditingController description = TextEditingController();


 @override
  onReady() {
    super.onReady();
    postModel.bindStream(getPost());
  }


  //Post gönderme
  postSend() {
    shoewLoading();
    String _userId = auth.currentUser!.uid;
    firebaseFirestore.collection(postCollection).doc().set({
      "id": _userId,
      "description": description.text.trim(),
      "imageUrl": imageUrl,
    });
    Get.back();
    Get.snackbar('Gönderi Eklendi', 'İşlem başarılı');
  }

  Stream<PostModel> getPost(){
    var a = firebaseFirestore.collection(postCollection).doc().snapshots().map((snapshot) => PostModel.fromSnapshot(snapshot) );
    return a;
  }

}
