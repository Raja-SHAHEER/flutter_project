import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'auth_services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  // late FToast fToast;
  // @override
  // void initState() {
  //   super.initState();
  //   fToast = FToast();
  //   fToast.init(context);
  // }
  bool isHidden = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child:Form(
            key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
               margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height / 6,
                ),
                height: 190,
                width: 150,
                child: Image.asset("assets/login.png",fit: BoxFit.contain,),
              ),
              Container(
                  margin: EdgeInsets.all(55),
                  child: Text("LOGIN",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38))),

              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2.5,
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "EMAIL...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                      prefixIcon: Icon(Icons.mail),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  validator: (email)=>!EmailValidator.validate(email!)
                    ?'Enter Valid Email'
                      :null,
                ),
              ),
              Container(

                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2.5,vertical: 15,
                ),
                child: TextFormField(
                  maxLength: 6,
                  controller: passwordController,
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    hintText: "PASSWORD...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      icon: isHidden ? Icon(Icons.visibility_off):Icon(Icons.visibility),
                      onPressed: togglePasswordVisibility,
                    )
                  ),
                //  keyboardType: TextInputType.visiblePassword,
                  validator: (password)=> password!=null&&password.length <6
                      ?'Enter Minimum 6 Characters'
                      :null,
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.all(40),
                width: MediaQuery.of(context).size.width / 8,
                // color: Colors.redAccent,
                child: FlatButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55)),
                  // highlightColor: Colors.redAccent,
                  onPressed: () {
                    final String email = emailController.text.trim().toString();
                    final String password = passwordController.text.trim().toString();
                    final form = formKey.currentState!;
                    if (email.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Email is Empty",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    else {
                      if (password.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Password is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.redAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }
                      else {
                        context.read<AuthService>().login(
                              email,
                              password,
                            );

                        if(form.validate()){
                            ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar();
                                // ..showSnackBar(SnackBar(
                                //   content: Text('your email is $email'),
                                // ));
                        }

                      }
                    }
                  },
                  child: Text("LOG IN"),
                ),
              ),
              // Container(
              //   height: 40,
              //   width: MediaQuery.of(context).size.width / 3,
              //   color: Colors.red,
              //   child: FlatButton(
              //     onPressed: () {
              //       final String email = emailController.text.trim().toString();
              //       final String password =
              //           passwordController.text.trim().toString();
              //
              //       if (email.isEmpty) {
              //         print("Email is Empty");
              //       } else {
              //         if (password.isEmpty) {
              //           print("Password is Empty");
              //         } else {
              //           context
              //               .read<AuthService>()
              //               .signUp(
              //                 email,
              //                 password,
              //               )
              //               .then((value) async {
              //             User? user = FirebaseAuth.instance.currentUser;
              //
              //             await FirebaseFirestore.instance
              //                 .collection("users")
              //                 .doc(user?.uid)
              //                 .set({
              //               'uid': user?.uid,
              //               'email': email,
              //               'password': password,
              //             });
              //           });
              //         }
              //       }
              //     },
              //     child: Text("SIGN UP"),
              //   ),
              // ),
            ],
          ),
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() =>isHidden=!isHidden);
}
