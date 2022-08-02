import 'package:fashion_app/src/const/app_colors.dart';
import 'package:fashion_app/src/const/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/auth_viemodel.dart';
import 'component/addaddress/text_field_address.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final nameController = TextEditingController();
  final noHp = TextEditingController();

  final passController = TextEditingController();

  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 20,
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Sign up",
                  style: AppFont.bold.copyWith(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFieldAddress(
                    textEditingController: nameController,
                    lableText: "Nama Lengkap"),
                SizedBox(
                  height: 10,
                ),
                TextFieldAddress(
                    textEditingController: noHp,
                    lableText: "No Hp"),
                SizedBox(
                  height: 10,
                ),
                TextFieldAddress(
                    textEditingController: emailController, lableText: "Email"),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ]),
                  child: TextFormField(
                    controller: passController,
                    obscureText: isShowPass,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Password",
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isShowPass = !isShowPass;
                            });
                          },
                          child: Icon(
                            isShowPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 16,
                          )),
                      alignLabelWithHint: true,
                      // center labastyle
                      labelStyle: AppFont.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Already have an account?",
                      style: AppFont.medium.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    onPressed: () {
                      authViewModel.register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passController.text.trim(),
                          noHp.text.trim());
                    },
                    child: Text(
                      "Daftar Sekarang".toUpperCase(),
                      style: AppFont.medium
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
                // Center(
                //   child: Text(
                //     'Or login with social account',
                //     style: AppFont.medium.copyWith(
                //       fontSize: 13,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 80),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Container(
                //         width: 80,
                //         height: 65,
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(20),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.grey.withOpacity(.1),
                //                 offset: Offset(1, 1),
                //                 blurRadius: 1,
                //                 spreadRadius: 2,
                //               )
                //             ]),
                //         child: SvgPicture.asset(
                //           'assets/image/ic_google.svg',
                //           width: 10,
                //           height: 10,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //       Container(
                //         width: 80,
                //         height: 65,
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(20),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.grey.withOpacity(.1),
                //                 offset: Offset(1, 1),
                //                 blurRadius: 1,
                //                 spreadRadius: 2,
                //               )
                //             ]),
                //         child: SvgPicture.asset(
                //           'assets/image/ic_fb.svg',
                //           width: 10,
                //           height: 10,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
