import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_guncelleme/constants/firebase.dart';
import 'package:firebase_guncelleme/helpers/show_loading.dart';
import 'package:firebase_guncelleme/models/user_model.dart';
import 'package:firebase_guncelleme/views/login_page.dart';
import 'package:firebase_guncelleme/views/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoaggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final String usersCollection = "users";
  Rx<UserModel> userModel = UserModel(email: 'Şimdilik boş', id: '', name: 'Osman').obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => const MyHomePage());
    }
  }

  void signIn() async {
    try {
      shoewLoading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _initializeUserModel(_userId);
        Get.snackbar('Giriş Yapma ', 'Başarılı');
      });
    } on FirebaseAuthException catch (e) {
      dismissLoadingWidget();
      debugPrint(e.toString());
      if (e.code == "user-not-found") {
        print('Yanlış Kullanıcı adı veya Email adresi');
        Get.defaultDialog(
          title: 'Oturum açma hatası',
          content: Text('Üzgünüz böyle bir kullanıcı bulunamadı!'),
        );
      }else if(e.code == "wrong-password"){
        Get.defaultDialog(
         title: 'Oturum açma hatası',
         buttonColor: Colors.indigo,
         
         textCancel: 'Kapat',
         titleStyle: TextStyle(background: Paint()..color = Colors.red),
         content: Text('Parola yanlış'),
         onCancel: (){
           Get.back();
         }
        );
      }
    }
  }

  void signUp() async {
    try {
      shoewLoading();
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _initializeUserModel(_userId);
        Get.snackbar('Kayıt Ol', 'Başarılı');
      });
    } on FirebaseAuthException catch (e) {
      dismissLoadingWidget();
      debugPrint(e.toString());
      Get.snackbar('Giriş Başarısız', 'Tekrar Dene');
      if (e.code == 'weak-password') {
        Get.defaultDialog(
            title: 'Hata Meydana geldi',
            content: const Text('Verilen parola çok zayıf.'));
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
            title: 'Hata Meydana geldi',
            content: const Text('Hesap bu e-posta için zaten mevcut.'));
      }
    }
  }

  void _addUserToFirestore(String _userId) {
    firebaseFirestore.collection(usersCollection).doc(_userId).set({
      "name": name.text.trim(),
      "id": _userId,
      "email": email.text.trim(),
    });
  }

  _initializeUserModel(String _userId) async {
    firebaseFirestore
        .collection(usersCollection)
        .doc(_userId)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  void signOut() async {
    auth.signOut();
  }

  /* Stream<QuerySnapshot> getUser(){
    String _userId = auth.currentUser!.uid;
    var ref = firebaseFirestore.collection(usersCollection).doc(_userId).get();
    return ref;
  }
 */

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));

}
