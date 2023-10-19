import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/layout.dart';
import 'package:flutter_web/pages/authentication/login_view_model.dart';
import 'package:flutter_web/routing/routes.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  final GlobalKey<FormState> formKey = GlobalKey();
  LoginViewModel _viewModel = Get.put(LoginViewModel());

  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(24),
            child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png",width: 60,),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Connexion",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Bienvenue dans le panneau d'administration",
                      color: lightGrey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailCtr,
                  decoration: InputDecoration(
                      labelText: "Nom d\'utilisateur",
                      hintText: "ahmed123",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),

                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordCtr,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Mot de passe",
                      hintText: "123",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async  {
                    if (formKey.currentState?.validate() ?? false) {
                      await _viewModel.loginUser(emailCtr.text, passwordCtr.text);
                    }
                    // Get.offAllNamed(RootRoute);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CustomText(
                      text: "Se connecter",
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 15,),

              ],
            )),
          )),
    );
  }
}