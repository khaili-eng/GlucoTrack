import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color/app_color.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_feild.dart';
import '../widgets/dropdown.dart';

class EditeProfilePage extends StatefulWidget {
  const EditeProfilePage({super.key});

  @override
  State<EditeProfilePage> createState() => _EditeProfilePageState();
}

class _EditeProfilePageState extends State<EditeProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  String? selectedDiabetesType;
  String originalName = "Ahmad Ali";
  String originalEmail = "ahmad@email.com";
  String originalDiabetesType = "سكري نوع 1";
  @override
  void initState() {
    nameController.text=originalName;
    emailController.text=originalEmail;
    selectedDiabetesType=originalDiabetesType;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundNeutral,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.backgroundNeutral,
        centerTitle: true,
        title: Text(
          context.read<LocaleCubit>().translate('edit_profile'),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.textNeutral,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.bell,
              color: AppColor.info,
              size: 22.sp,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //header card
              Container(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: BoxDecoration(
                  color: AppColor.info.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 90.w,
                      height: 90.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.info.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.person_outline,
                        size: 42.sp,
                        color: AppColor.info,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                     context.read<LocaleCubit>().translate('account_information'),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textNeutral,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
              //form card
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 22.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// Name
                    AppTextField(
                      controller: nameController,
                      label: context.read<LocaleCubit>().translate('full_name'),
                      icon: Icons.person_outline,
                      iconColor: AppColor.info,
                      labelColor: AppColor.textNeutral,
                    ),
                    SizedBox(height: 18.h),
                    /// Email
                    AppTextField(
                      controller: emailController,
                      label: context.read<LocaleCubit>().translate('email'),
                      icon: Icons.email_outlined,
                      iconColor: AppColor.info,
                      labelColor: AppColor.textNeutral,
                    ),
                    SizedBox(height: 18.h),
                    /// Diabetes Type
                    Dropdown(
                      label: context.read<LocaleCubit>().translate('types'),
                      items: [
                        context.read<LocaleCubit>().translate('type1'),
                        context.read<LocaleCubit>().translate('type2')],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),
     //button for save
              SizedBox(
                height: 54.h,
                child: AppButton(
                  text: 'حفظ التعديلات',
                  icon: Icons.save_outlined,
                  textColor: AppColor.textNeutral,
                  iconColor:AppColor.info,
                  backgroundColor: AppColor.positive,
                  onPressed: () {
                    final hasChanges = nameController.text.trim() != originalName ||
                        emailController.text.trim() != originalEmail ||
                        selectedDiabetesType != originalDiabetesType;
                    if(hasChanges){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('profile updated successfully'),
                          backgroundColor: AppColor.positive,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      );
                      //update values after save changes
                      originalName = nameController.text.trim();
                      originalEmail = emailController.text.trim();
                      originalDiabetesType = selectedDiabetesType ?? "";
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: const  Text("Everything is up to date"),
                        backgroundColor: AppColor.negative,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),)
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}