import 'package:flutter/material.dart';
import 'package:get/get.dart';

shoewLoading(){
  Get.defaultDialog(
    title: 'Loading..',
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
  );
}

dismissLoadingWidget(){
  Get.back();
}