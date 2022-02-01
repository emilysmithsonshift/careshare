import 'package:careshare/profile/cubit/profile_cubit.dart';
import 'package:careshare/profile/models/profile.dart';

import 'package:careshare/profile/presenter/profile_widgets/profile_input_field_widget.dart';
import 'package:careshare/widgets/careshare_appbar.dart';
import 'package:careshare/widgets/careshare_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class ProfileDetailedView extends StatelessWidget {
  final Profile profile;

  const ProfileDetailedView({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double spacing = 16;
    return Scaffold(
      appBar: CareshareAppBar('Profile Details'),
      endDrawer: CareshareDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: spacing),
                  ProfileInputFieldWidget(
                    label: 'Title',
                    maxLines: 1,
                    currentValue: profile.name,
                    profile: profile,
                    onChanged: (value) {
                      BlocProvider.of<ProfileCubit>(context)
                          .editProfileFieldRepository(
                        profileField: ProfileField.name,
                        profile: profile,
                        newValue: value,
                      );
                    },
                    
                  ),

                  const SizedBox(height: spacing),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Save')),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
