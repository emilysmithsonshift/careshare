import 'package:careshare/authentication/cubit/authentication_cubit.dart';
import 'package:careshare/authentication/presenter/authentication_page.dart';
import 'package:careshare/category_manager/cubit/category_cubit.dart';
import 'package:careshare/home_page/home_page.dart';
import 'package:careshare/profile_manager/cubit/profile_cubit.dart';
import 'package:careshare/profile_manager/presenter/edit_profile.dart';
import 'package:careshare/profile_manager/presenter/profile_overview.dart';
import 'package:careshare/profile_manager/presenter/profile_widgets/profile_summary.dart';
import 'package:careshare/profile_manager/repository/edit_profile_field_repository.dart';
import 'package:careshare/task_manager/cubit/task_cubit.dart';
import 'package:careshare/task_manager/presenter/task_detailed_view/task_detailed_view.dart';
import 'package:careshare/task_manager/presenter/task_manager_view.dart';
import 'package:careshare/task_manager/repository/create_a_task.dart';
import 'package:careshare/task_manager/repository/edit_task_field_repository.dart';
import 'package:careshare/task_manager/repository/remove_a_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../profile_manager/models/profile.dart';
import '../task_manager/models/task.dart';

class AppRouter {
  final _profileCubit = ProfileCubit(
    editProfileFieldRepository: EditProfileFieldRepository(),
  );
  final _taskCubit = TaskCubit(
    createATaskRepository: CreateATask(),
    editTaskFieldRepository: EditTaskFieldRepository(),
    removeATaskRepository: RemoveATask(),
  );
  final _categoriesCubit = CategoriesCubit();
  final _authenticationCubit = AuthenticationCubit();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AuthenticationPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileCubit,
            child: BlocProvider.value(
              value: _taskCubit,
              child: BlocProvider.value(
                value: _categoriesCubit,
                child: const AuthenticationPage(),
              ),
            ),
          ),
        );

      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileCubit,
            child: BlocProvider.value(
              value: _authenticationCubit,
              child: const HomePage(),
            ),
          ),
        );

      case TaskManagerView.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileCubit,
            child: BlocProvider.value(
              value: _taskCubit,
              child: BlocProvider.value(
                value: _categoriesCubit,
                child: const TaskManagerView(),
              ),
            ),
          ),
        );
      case TaskDetailedView.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileCubit,
            child: BlocProvider.value(
              value: _taskCubit,
              child: BlocProvider.value(
                value: _categoriesCubit,
                child:
                    TaskDetailedView(task: routeSettings.arguments as CareTask),
              ),
            ),
          ),
        );
      case ProfileSummary.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileCubit,
            child: ProfileSummary(profile: routeSettings.arguments as Profile),
          ),
        );
      case ProfilesManager.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileCubit,
            child: const ProfilesManager(),
          ),
        );
      case EditProfile.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _profileCubit,
            child: EditProfile(profile: routeSettings.arguments as Profile),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authenticationCubit,
            child: BlocProvider.value(
              value: _profileCubit,
              child: BlocProvider.value(
                value: _taskCubit,
                child: const AuthenticationPage(),
              ),
            ),
          ),
        );
    }
  }
}
