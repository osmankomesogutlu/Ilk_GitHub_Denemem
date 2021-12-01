import 'package:firebase_guncelleme/constants/auth_controller.dart';
import 'package:firebase_guncelleme/controllers/post_controller.dart';
import 'package:firebase_guncelleme/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Obx(
              () => UserAccountsDrawerHeader(
                accountName: Text(authController.userModel.value.name),
                accountEmail: Text(authController.userModel.value.email),
              ),
            ),
            ListTile(
              onTap: () {
                authController.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _gonderiEkleme(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Obx(() => Container(
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(postController.postModel.value.imageUrl),
                                fit: BoxFit.cover,
                                ),),
                                child: Text(postController.postModel.value.description),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postController.postSend();
        },
        child: Icon(Icons.post_add),
      ),
    );
  }

  Container _gonderiEkleme() {
    return Container(
      height: 300,
      width: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/06/19/21/24/avenue-815297_960_720.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text('')),
          SizedBox(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: postController.description,
                style: const TextStyle(
                  color: Colors.blue,
                ),
                validator: (value) {},
                cursorColor: Colors.blue,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  hintText: 'Description',
                  prefixText: ' ',
                  hintStyle: TextStyle(color: Colors.blue),
                  focusColor: Colors.blue,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
