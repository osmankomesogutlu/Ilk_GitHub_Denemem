import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_guncelleme/constants/app_constants.dart';
import 'package:firebase_guncelleme/constants/auth_controller.dart';
import 'package:firebase_guncelleme/constants/firebase.dart';
import 'package:firebase_guncelleme/data/services/auth_service.dart';
import 'package:firebase_guncelleme/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  GlobalKey _controller = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //final singIn = Get.put(AuthService());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: size.height * 0.5,
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(.75),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: _textField(),
          ),
        ),
      ),
    );
  }

  Padding _textField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _controller,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _nameTextField(),
                AppConstants.araBosluk,
              _emailTextField(),
              AppConstants.araBosluk,
              _passwordTextField(),
              AppConstants.araBosluk,
              _registerButton(),
              AppConstants.araBosluk,
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _loginButton() {
    return InkWell(
      onTap: () {
        Get.to(()=>LoginPage());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 1,
            width: 75,
            color: Colors.white,
          ),
          const Text(
            "Giriş Yap",
            style: TextStyle(color: Colors.white),
          ),
          Container(
            height: 1,
            width: 75,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  InkWell _registerButton() {
    return InkWell(
      onTap: () {
        authController.signUp();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            //color: colorPrimaryShade,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              "Kayıt Ol",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _passwordTextField() {
    return TextFormField(
      controller: authController.password,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (value) {
        return value!.length < 5 ? 'Şifre en az 5 karekter olmalı' : null;
      },
      cursorColor: Colors.white,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white,
        ),
        hintText: 'Password',
        prefixText: ' ',
        hintStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  TextFormField _emailTextField() {
    return TextFormField(
      controller: authController.email,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (value) {
        // GetUtils.isEmail(value!) ? validate() : errorMessage();
        if (!value!.contains('@') || !value.contains('.com')) {
          return 'Lütfen geçerli bir e-mail hesabı girin';
        }
      },
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white,
        ),
        hintText: 'E-Mail',
        prefixText: ' ',
        hintStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  TextFormField _nameTextField() {
    return TextFormField(
      controller: authController.name,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (value) {
        // GetUtils.isEmail(value!) ? validate() : errorMessage();
        if (value!.length<3) {
          return 'Lütfen geçerli bir isim girin';
        }
      },
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        hintText: 'Name',
        prefixText: ' ',
        hintStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

 /*  yeniMetot() {
    singIn.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Kullanıcı çıkış yaptı');
      } else {
        print('Kullanıcı Giriş Yaptı');
      }
    });
  } */
}
