import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../const/app_colors.dart';
import '../../const/app_font.dart';
import '../../viewmodel/auth_viemodel.dart';
import 'component/addaddress/text_field_address.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({Key? key}) : super(key: key);

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  final emailController = TextEditingController();

  final nameController = TextEditingController();
  final noHp = TextEditingController();

  final passController = TextEditingController();
  GetStorage session = GetStorage();

  @override
  void initState() {
    setState(() {
      nameController.text = session.read('username');
      emailController.text = session.read('email');
      noHp.text = session.read('no_hp');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFieldAddress(
              textEditingController: nameController, lableText: "Nama Lengkap"),
          SizedBox(
            height: 10,
          ),
          TextFieldAddress(textEditingController: noHp, lableText: "No Hp"),
          SizedBox(
            height: 10,
          ),
          TextFieldAddress(
              textEditingController: emailController, lableText: "Email"),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColorRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                authViewModel.updateUser(nameController.text.trim(),
                    emailController.text.trim(), noHp.text.trim());
              },
              child: Text(
                "Simpan".toUpperCase(),
                style:
                    AppFont.medium.copyWith(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
