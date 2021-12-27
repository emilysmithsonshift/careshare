import 'package:flutter/material.dart';

import '../domain/models/profile.dart';
import '../domain/usecases/all_profile_usecases.dart';
import 'profile_entered_screen.dart';

class CreateOrEditAProfileController {
  final formKey = GlobalKey<FormState>();
  bool isCreateProfile = true;
  Profile? storedProfile;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController taskTypesController;

  initialiseControllers(Profile? originalProfile) {
    if (originalProfile != null) {
      storedProfile = originalProfile;
      isCreateProfile = false;
    }
    firstNameController = TextEditingController(
      text: originalProfile?.firstName,
    );
    lastNameController = TextEditingController(
      text: originalProfile?.lastName,
    );
    taskTypesController = TextEditingController(
      text: originalProfile?.taskTypes,
    );
  }

  createAProfile({
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      final Profile profile = storedProfile!;
      profile.firstName = firstNameController.text;
      profile.lastName = lastNameController.text;
      profile.dateCreated = DateTime.now();
      profile.taskTypes = taskTypesController.text;

      if (isCreateProfile) {
        final response = await AllProfileUseCases.createAProfile(profile);
        response.fold((l) => null, (r) => profile.id = r);
      } else {
        AllProfileUseCases.editAProfile(profile);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileEnteredScreen(profile: profile),
        ),
      );
    }
  }
}
