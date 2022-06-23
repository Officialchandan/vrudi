import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vrudi/ui/firebase/firebase_methods.dart';
import 'package:vrudi/ui/login/login_scren.dart';
import 'package:vrudi/ui/signup/bloc/signup_bloc.dart';
import 'package:vrudi/ui/signup/bloc/signup_event.dart';
import 'package:vrudi/ui/signup/bloc/signup_state.dart';
import 'package:vrudi/utility/utilty.dart';
import 'package:vrudi/utility/validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpBloc signUpBloc = SignUpBloc();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController selectSecurityController = TextEditingController();
  TextEditingController securityController = TextEditingController();
  TextEditingController userTypeController = TextEditingController();
  TextEditingController professionalController = TextEditingController();
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return BlocProvider<SignUpBloc>(
      create: (context) => signUpBloc,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/bg.jpg",
                fit: BoxFit.cover,
                width: deviceWidth,
                height: deviceHeight,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/trans_logo.png",
                        height: deviceHeight * 0.20,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.05,
                    ),
                    TextFormField(
                      validator: (numb) => Validator.emailValidator(numb!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        counterText: "",
                        hintText: "Please Enter Email Id",
                        prefixIcon:
                            Icon(Icons.email, color: Colors.black),

                        prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                            maxWidth: 51,
                            maxHeight: 25),
                        // errorText: Validator.validateMobile(edtMobile.text, context),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        counterText: "",
                        hintText: "Please Enter Full name",
                        prefixIcon:
                            Icon(Icons.person, color: Colors.black),

                        prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                            maxWidth: 51,
                            maxHeight: 25),
                        // errorText: Validator.validateMobile(edtMobile.text, context),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: usernameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        counterText: "",
                        hintText: "Please Enter User Name",
                        prefixIcon: Icon(Icons.supervised_user_circle,
                            color: Colors.black),

                        prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                            maxWidth: 51,
                            maxHeight: 25),
                        // errorText: Validator.validateMobile(edtMobile.text, context),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (numb) => Validator.passwordValidator(numb!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      controller: passwordController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        counterText: "",
                        hintText: "Please Enter Password",
                        prefixIcon: Icon(Icons.key, color: Colors.black),

                        prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                            maxWidth: 51,
                            maxHeight: 25),
                        // errorText: Validator.validateMobile(edtMobile.text, context),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (numb) => Validator.passwordValidator(numb!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      controller: confirmController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        counterText: "",
                        hintText: "Please Enter Password Again",
                        prefixIcon: Icon(Icons.key, color: Colors.black),

                        prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                            maxWidth: 51,
                            maxHeight: 25),
                        // errorText: Validator.validateMobile(edtMobile.text, context),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        bottomSheet();
                      },
                      controller: selectSecurityController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        counterText: "",
                        hintText: "select fav Color",
                        prefixIcon: Icon(Icons.arrow_drop_down,
                            color: Colors.black),

                        prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                            maxWidth: 51,
                            maxHeight: 25),
                        // errorText: Validator.validateMobile(edtMobile.text, context),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                        readOnly: true,
                        onTap: () {
                          bottomSheetUserTypr();
                        },
                        keyboardType: TextInputType.visiblePassword,
                        validator: (numb) => Validator.passwordValidator(numb!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                        controller: userTypeController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          counterText: "",
                          hintText: "Please Select User Type",
                          suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
                          prefix: Text("  "),
                          suffixIconConstraints: BoxConstraints(minWidth: 50, minHeight: 25, maxWidth: 51, maxHeight: 25),
                          // errorText: Validator.validateMobile(edtMobile.text, context),
                        ),
                      ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        bottomSheetProfessional();
                      },
                      keyboardType: TextInputType.visiblePassword,
                      validator: (numb) => Validator.passwordValidator(numb!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                      controller: professionalController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        counterText: "",
                        hintText: "Please Select User Professional",
                        suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        prefix: Text("  "),
                        suffixIconConstraints: BoxConstraints(minWidth: 50, minHeight: 25, maxWidth: 51, maxHeight: 25),
                        // errorText: Validator.validateMobile(edtMobile.text, context),
                      ),
                    ),
                    BlocConsumer<SignUpBloc, SignUpState>(
                        bloc: signUpBloc,
                        listener: (context, state) {
                          log("sate====>$state");
                          if (state is GetSignUpState) {
                            signUpEvent();
                          }
                          if (state is SignUpFailureState) {
                            Utility.showToast(
                              msg: state.message,
                            );
                          }
                          if (state is SignUpInitialState) {
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.70,
                                child:
                                    const Center(child: const CircularProgressIndicator()));
                          }
                        },
                        builder: (context, state) {
                          return MaterialButton(
                            minWidth: deviceWidth * 0.84,
                            height: 50,
                            padding: const EdgeInsets.all(8.0),
                            textColor: Colors.white,
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              // signUpEvent();
                              signUp(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                  securityQuestion: securityController.text,
                                  username: usernameController.text,
                                  professional: "text7",
                                  securityAnswer: "text7",
                                  usertype: "text7");
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
  void bottomSheetUserTypr() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(topLeft: const Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Employee'),
                  onTap: () {
                    userTypeController.text = "Employee";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Professional'),
                  onTap: () {
                    userTypeController.text = "Professional";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Client'),
                  onTap: () {
                    userTypeController.text = "Client";
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
  void bottomSheetProfessional() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(topLeft: const Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Chartered Accountant'),
                  onTap: () {
                    professionalController.text = "Chartered Accountant";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Designer'),
                  onTap: () {
                    professionalController.text = "Designer";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Lawyer'),
                  onTap: () {
                    professionalController.text = "Lawyer";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Estate Agent'),
                  onTap: () {
                    professionalController.text = "Estate Agent";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Photographer'),
                  onTap: () {
                    professionalController.text = "Photographer";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Information Technology'),
                  onTap: () {
                    professionalController.text = "Information Technology";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Content Creator'),
                  onTap: () {
                    professionalController.text = "Content Creator";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Builder'),
                  onTap: () {
                    professionalController.text = "Builder";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Marketing Professional'),
                  onTap: () {
                    professionalController.text = "Marketing Professional";
                    Navigator.pop(context);
                  },
                ),ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Financial Consultant'),
                  onTap: () {
                    professionalController.text = "Financial Consultant";
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
  signUpEvent() async {
    createAccount(
            nameController.text, emailController.text, passwordController.text)
        .then((user) async {
      if (user != null) {
        print("Login Succesfulle");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => true);
      } else {
        print("Login UnSuccesfulle");
      }
    });
    // if (emailController.text.isEmpty) {
    //   Utility.showToast(msg: "Please Enter userName");
    // } else if (nameController.text.isEmpty) {
    //   Utility.showToast(msg: "Please Enter Password");
    // } else if (usernameController.text.isEmpty) {
    //   Utility.showToast(msg: "Please Enter Password");
    // } else if (passwordController.text.isEmpty) {
    //   Utility.showToast(msg: "Please Enter Password");
    // } else if (confirmController.text.isEmpty) {
    //   Utility.showToast(msg: "Please Enter Password");
    // } else if (selectSecurityController.text.isEmpty) {
    //   Utility.showToast(msg: "Please Enter Password");
    // } else {
    //   Map<String, dynamic> loginInput = Map<String, dynamic>();
    //   loginInput["email"] = emailController.text;
    //   loginInput["fullName"] = nameController.text;
    //   loginInput["userName"] = usernameController.text;
    //   loginInput["password"] = passwordController.text;
    //   loginInput["securityQuestionAnswer"] = confirmController.text;
    //   loginInput["securityQuestion"] = "select fav Colors";
    //   loginInput["userType"] = "advocate";
    //   loginInput["industry"] = "law";
    //   log("loginInput====>$loginInput");
    //   CircularProgressIndicator();
    //   signUpBloc.add(GetSignUpEvent(input: loginInput));
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Orange'),
                  onTap: () {
                    selectSecurityController.text = "Photo";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('White'),
                  onTap: () {
                    selectSecurityController.text = "White";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Black'),
                  onTap: () {
                    selectSecurityController.text = "Black";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.share),
                  title: new Text('Red'),
                  onTap: () {
                    selectSecurityController.text = "Red";
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void signUp(
      {required String email,
      required String password,
      required String username,
      required String name,
      required String usertype,
      required String professional,
      required String securityQuestion,
      required String securityAnswer}) {
    if (email.isEmpty) {
      Utility.showToast(msg: "Please Enter Email");
    } else if (password.isEmpty) {
      Utility.showToast(msg: "Please Enter Password");
    } else if (username.isEmpty) {
      Utility.showToast(msg: "Please Enter Username");
    } else if (name.isEmpty) {
      Utility.showToast(msg: "Please Enter Name");
    } else if (usertype.isEmpty) {
      Utility.showToast(msg: "Please Enter Usertype");
    } else {
      Map<String, dynamic> signUpInput = <String, dynamic>{};
      signUpInput['email'] = email;
      signUpInput['password'] = password;
      signUpInput['username'] = username;
      signUpInput['name'] = name;
      signUpInput['usertype'] = 'test9';
      signUpInput['professional'] = 'test9';
      signUpInput['securityQuestion'] = 'test9';
      signUpInput['securityAnswer'] = 'test9';
      print("input-->$signUpInput");
      signUpBloc.add(GetSignUpEvent(input: signUpInput));
    }
  }
}
