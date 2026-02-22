import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:untitled10/core/color/app_color.dart';
import 'package:untitled10/core/localization/locale_cubit.dart';
import 'package:untitled10/core/localization/locale_state.dart';
import 'package:untitled10/core/routes/app_routes.dart';

import 'package:untitled10/features/auth/presentaion/manager/auth_cubit.dart';


import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled10/features/user/presentation/manager/user_cubit.dart';

import 'core/di/injection.dart';
import 'features/auth/data/datasource/auth_remote_datasource.dart';
import 'features/auth/domain/usecase/forgot_password_usecase.dart';
import 'features/auth/domain/usecase/login_usecase.dart';
import 'features/auth/domain/usecase/reset_password_usecase.dart';
import 'features/auth/domain/usecase/verify_usecase.dart';
import 'features/auth/repo/auth_repo_impl.dart';
import 'features/user/data/datasource/user_remote_datasource.dart';
import 'features/user/domain/usecase/create_user_usecase.dart';
import 'features/user/domain/usecase/get_user_usecase.dart';
import 'features/user/domain/usecase/update_user_usecase.dart';
import 'features/user/domain/usecase/delete_user_usecase.dart';
import 'features/user/repo/user_repo_impl.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [


        BlocProvider(create: (_)=>LocaleCubit()),
        BlocProvider(create: (_)=>AuthCubit(
            loginUseCase: LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
            forgotPasswordUseCase: ForgotPasswordUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
            verifyOtpUseCase: VerifyOtpUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
            resetPasswordUseCase: ResetPasswordUseCase(AuthRepositoryImpl(AuthRemoteDataSource())))),
        BlocProvider(create:(_)=>UserCubit(
            createUserUseCase: CreateUserUseCase(UserRepositoryImpl(UserRemoteDataSource())),
            getUserUseCase: GetUserUseCase(UserRepositoryImpl(UserRemoteDataSource())),
            updateUserUseCase: UpdateUserUseCase(UserRepositoryImpl(UserRemoteDataSource())),
            deleteUserUseCase: DeleteUserUseCase(UserRepositoryImpl(UserRemoteDataSource()))) )
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return Sizer(
                  builder: (context,orientation, deviceType) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      locale: context.read<LocaleCubit>().currentLocale,
                      supportedLocales: const [
                        Locale('en'),
                        Locale('ar'),
                      ],
                      localizationsDelegates: const [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      theme: ThemeData(
                        scaffoldBackgroundColor: AppColor.backgroundNeutral,
                        primaryColor: AppColor.positive,
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(secondary: AppColor.textNeutral),
                      ),
                      initialRoute: AppRoutes.started,
                      routes: AppRoutes.routes,

                    );
                  }
              );
            },

          );
        },
      ),
    );
  }
}
