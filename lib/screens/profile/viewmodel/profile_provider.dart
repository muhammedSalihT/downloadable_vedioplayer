import 'dart:developer';
import 'dart:io';

import 'package:downloadeble_videoplayer/screens/profile/model/profile_model.dart';
import 'package:downloadeble_videoplayer/services/local_database_service.dart';
import 'package:downloadeble_videoplayer/utils/refracted_util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController dobCtr = TextEditingController();
  File? fileImage;
  final formKey = GlobalKey<FormState>();
  bool isSaving = false;

  void getProfileData() async {
    try {
      final userData = await LocalDatabaseService.getUserData();
      nameCtr.text = userData?.userName ?? '';
      emailCtr.text = userData?.userEmail ?? '';
      dobCtr.text = userData?.userDob ?? '';
      fileImage = File(userData?.userImage ?? '');
      notifyListeners();
    } catch (e) {}
  }

  void saveUserData() async {
    try {
      isSaving = true;
      notifyListeners();
      if (formKey.currentState!.validate()) {
        final data = ProfileModel(
            userName: nameCtr.text,
            userEmail: emailCtr.text,
            userDob: dobCtr.text,
            userImage: fileImage!.path);
        await LocalDatabaseService.saveUser(data);
        UtilWidgets.getToast(showText: 'Saved Successfully');
      }
    } catch (e) {
      isSaving = false;
      notifyListeners();
      log(e.toString());
    }
    isSaving = false;
    notifyListeners();
  }

  void takeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? data = await picker.pickImage(source: ImageSource.gallery);

      if (data != null) {
        fileImage = File(data.path);
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
