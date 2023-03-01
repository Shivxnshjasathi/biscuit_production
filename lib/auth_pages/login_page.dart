import 'package:biscuit_production/auth_pages/signup_page.dart';
import 'package:biscuit_production/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../splash_screen.dart';
import 'auth_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  bool _loginWithNumber = false;
  bool _otpSent = false;

  final _loginFormKey = GlobalKey<FormState>();
  String _emailText = '';
  String _passwordText = '';
  String _mobileNumberText = '';
  String _otpText = '';
  String? _userId = null;

  void LoginWithEmail() async {
    userToken = await AuthService.instance.loginWithEmailAndPassword(
      email: _emailText.trim(),
      password: _passwordText.trim(),
    );
    if (userToken != null) {
      await showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Successfully Logged in"),
        ),
      );
      SetToken();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AuthScreen();
            },
          ),
        );

      return;
    }
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("something went wrong"),
      ),
    );
  }

  void LoginWithNumber() async {
    _otpSent = false;
    setState(() {});
    _userId = await AuthService.instance.loginWithMobileNumber(
      number: _mobileNumberText.trim(),
    );
    if (_userId != null) {
      setState(() {
        _otpSent = true;
      });
      await showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Otp Sent on your mobile number"),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("something went wrong"),
      ),
    );
  }
  void VerifyOTP() async {
    userToken = await AuthService.instance.verifyOTP(
      userId: _userId!,
      otp: _otpText
    );
    
    if (userToken != null) {




      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Successfully Logged in"),
        ),
      );
       SetToken();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AuthScreen();
            },
          ),
        );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("something went wrong"),
      ),
    );
  }


  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('assets/logos/biscuit-logo.png',
                          height: MediaQuery.of(context).size.height * .25),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Log In...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _loginFormKey,
                        child: _loginWithNumber
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Mobile Number",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      readOnly: _otpSent,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      decoration: InputDecoration(
                                          hintText: "Enter Mobile",
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: Colors.grey.shade900,
                                          border: InputBorder.none),
                                      onSaved: (newValue) {
                                        _mobileNumberText = newValue!.trim();
                                      },
                                      validator: (value) =>
                                          value!.trim().length != 10
                                              ? "Enter your valid Number"
                                              : null,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _otpSent ?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(6)
                                        ],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        decoration: InputDecoration(
                                            hintText: "Enter OTP",
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.bold),
                                            filled: true,
                                            fillColor: Colors.grey.shade900,
                                            border: InputBorder.none),
                                        onSaved: (newValue) {
                                          _otpText = newValue!.trim();
                                        },
                                        validator: (value) =>
                                            value!.trim().length != 6
                                                ? "Enter valid Otp"
                                                : null,
                                      ),
                                    ),
                                  ) :
                                  const SizedBox(
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      initialValue: _emailText,

                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      decoration: InputDecoration(
                                          hintText: "Enter your email",
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: Colors.grey.shade900,
                                          border: InputBorder.none),
                                      onSaved: (newValue) {
                                        _emailText = newValue!.trim();
                                      },
                                      validator: (value) =>
                                          value!.trim().isEmpty ||
                                                  !value.contains("@")
                                              ? "Enter your valid email"
                                              : null,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Password",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      obscureText: !_showPassword,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: "Enter your password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold),
                                        filled: true,
                                        fillColor: Colors.grey.shade900,
                                        border: InputBorder.none,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _showPassword = !_showPassword;
                                            });
                                          },
                                          child: Icon(
                                            !_showPassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      onSaved: (newValue) {
                                        _passwordText = newValue!.trim();
                                      },
                                      validator: (value) =>
                                          value!.trim().isEmpty
                                              ? "Enter your password"
                                              : null,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Divider(color: Colors.white,height: 40,thickness: 1),
                      MaterialButton(
                        color: const Color(0xFFDD904A),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _loginWithNumber && !_otpSent ? " Send otp" :"Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () async {
                          if (_loginFormKey.currentState!.validate()) {
                            _loginFormKey.currentState!.save();
                            if (_loginWithNumber) {
                              if(!_otpSent){
                                LoginWithNumber();
                                return;
                              }
                              VerifyOTP();
                              return;
                            }
                            LoginWithEmail();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Login with ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator
                              setState(() {
                                _otpSent = false;
                                _loginWithNumber = !_loginWithNumber;
                              });
                            },
                            child: Text(
                              _loginWithNumber ? "Email" : "Mobile Number",
                              style: TextStyle(
                                  color: Color(0xFFDD904A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          const Text(
                            " Instead",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,height: 40,thickness: 1,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        const Text(
                          "Not a member ? ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            
                            // Navigator
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                            setState(() {
                              _otpSent = false;
                            });
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                color: Color(0xFFDD904A),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/** 
void trailCall() async {
    var Response = await post(
        Uri.parse("https://bsctapi.qurinomsolutions.com/api/auth/register"),
        headers: {},
        body: {
          "name": "Parag jain",
          "email": "paragpj6@gmail.com",
          "password": "123456abc",
          "phone": "+919685538780",
          "dob": "08-06-2003",
          "gender": "male"
        });
    var data = jsonDecode(Response.body);
    print(data);
  }
  */