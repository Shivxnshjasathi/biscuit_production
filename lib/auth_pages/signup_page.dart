import 'package:biscuit_production/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  String userID = "63f521eb7abae1a203dcb4cc";
  final _signUpFormKey = GlobalKey<FormState>();
  String _emailText = '';
  String _passwordText = '';
  String _nameText = '';
  String _mobileNumberText = '';
  String _dobText = '';
  String _genderText = '';
  
  final _dobTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/logos/biscuit-logo.png',
                      height: MediaQuery.of(context).size.height * .10),
                  const Text(
                    "Register with us",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              Form(
                key: _signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          decoration: InputDecoration(
                              hintText: "Enter your name",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              border: InputBorder.none),
                          onSaved: (newValue) {
                            _nameText = newValue!.trim();
                          },
                          validator: (value) =>
                              value!.trim().isEmpty ? "Enter your name" : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
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
                              value!.trim().isEmpty || !value.contains("@")
                                  ? "Enter your valid email"
                                  : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          decoration: InputDecoration(
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              border: InputBorder.none),
                          onSaved: (newValue) {
                            _passwordText = newValue!.trim();
                          },
                          validator: (value) => value!.trim().isEmpty
                              ? "Enter your password"
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InternationalPhoneNumberInput(
                          maxLength: 10,
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          onInputChanged: (value) {
                            print(value);
                          },
                          keyboardType: TextInputType.number,
                          formatInput: true,
                          selectorTextStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          inputDecoration: InputDecoration(
                              hintText: "Enter your Mobile Number",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              border: InputBorder.none),
                          onSaved: (newValue) {
                            _mobileNumberText = newValue.phoneNumber!.trim();
                          },
                          validator: (value) =>
                              value!.trim().isEmpty || value.length != 10
                                  ? "Enter your Valid Mobile number"
                                  : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          onTap: () {
                            showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now()).then((value) => _dobTextController.text = DateFormat("dd-MM-yyyy").format(value!));
                          },
                          controller: _dobTextController,
                          readOnly: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          decoration: InputDecoration(
                              hintText: "Enter your Dob",
                              suffixIcon: Icon(Icons.calendar_month_outlined),
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              border: InputBorder.none),
                          onSaved: (newValue) {
                            _dobText = newValue!.trim();
                            print(_dobText);
                          },
                          validator: (value) =>
                              value!.trim().isEmpty ? "Enter your Dob" : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DropdownButtonFormField(
                          value: "male",
                          dropdownColor: Colors.grey.shade700,
                          items: const [
                            DropdownMenuItem<String>(
                              value: "male",
                              child: Text(
                                "Male",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "female",
                              child: Text(
                                "Female",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          decoration: InputDecoration(
                              hintText: "Select Your gender",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              border: InputBorder.none),
                          onSaved: (newValue) {
                            _genderText = newValue!.trim();
                          },
                          validator: (value) => value!.trim().isEmpty
                              ? "Enter your Gender"
                              : null,
                          onChanged: (String? value) {
                            _genderText = value!.trim();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                          color: const Color(0xFFDD904A),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          onPressed: () async {
                            if (_signUpFormKey.currentState!.validate()) {
                              _signUpFormKey.currentState!.save();
                              var userID = await AuthService.instance
                                  .ResisterUser(
                                      name: _nameText.trim(),
                                      email: _emailText.trim(),
                                      password: _passwordText.trim(),
                                      mobileNumber: _mobileNumberText.trim(),
                                      dob: _dobText.trim(),
                                      gender: _genderText.trim());
                              if (userID != null) {
                                await showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    content: Text("Successfully registered"),
                                  ),
                                );
                                Navigator.pop(context);
                                return;
                              }
                              await showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  content: Text("Something went wrong"),
                                ),
                              );
                              return;
                            }
                          }),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const Text("Already a member ? ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Color(0xFFDD904A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
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

   print('''
                                name: ${_nameText.trim()},
                                      email: ${_emailText.trim()},
                                      password: ${_passwordText.trim()},
                                      mobileNumber: ${_mobileNumberText.trim()},
                                      dob: ${_dobText.trim()},
                                      gender: ${_genderText.trim()}
                                    '''
                              );
  */