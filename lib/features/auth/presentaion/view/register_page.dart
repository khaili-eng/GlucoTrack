import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:untitled10/features/user/domain/create_user_parametres.dart';
import 'package:untitled10/features/user/domain/usecase/create_user_usecase.dart';
import 'package:untitled10/features/user/domain/usecase/delete_user_usecase.dart';
import 'package:untitled10/features/user/domain/usecase/get_user_usecase.dart';
import 'package:untitled10/features/user/domain/usecase/update_user_usecase.dart';
import 'package:untitled10/features/user/presentation/manager/user_cubit.dart';
import 'package:untitled10/features/user/presentation/manager/user_state.dart';
import 'package:untitled10/features/user/repo/user_repo_impl.dart';
import '../../../../core/color/app_color.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_feild.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColor.backgroundNeutral,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    context.read<LocaleCubit>().translate('register'),
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.info,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  AppTextField(
                    controller: nameController,
                    label: context.read<LocaleCubit>().translate('full_name'),
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.read<LocaleCubit>().translate('name_required');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: emailController,
                    label: context.read<LocaleCubit>().translate('email'),
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.read<LocaleCubit>().translate('email_required');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: passwordController,
                    label: context.read<LocaleCubit>().translate('password'),
                    icon: Icons.lock,
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return context.read<LocaleCubit>().translate('password_too_short');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is UserSuccess) {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      }
                      if (state is UserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.failure.message),
                            backgroundColor: AppColor.negative,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const CircularProgressIndicator();
                      }
                      return AppButton(
                        iconColor: AppColor.info,
                        text: context.read<LocaleCubit>().translate('register'),
                        icon: Icons.person_add,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UserCubit>().createUser(
                                   CreateUserParams(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}