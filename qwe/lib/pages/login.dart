import 'package:flutter/material.dart';
import 'package:qwe/Components/button.dart';
import 'package:qwe/Components/colors.dart';
import 'package:qwe/Components/textfield.dart';
import 'package:qwe/Json/users.dart';
import 'package:qwe/pages/profile.dart';
import 'package:qwe/pages/signup.dart';
import 'package:qwe/SQLite/database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  login() async {
    Users? usrDetails = await db.getUser(usrName.text);
    var res = await db
        .authenticate(Users(usrName: usrName.text, password: password.text));
    if (res == true) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(profile: usrDetails),
        ),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xFFFED7B0), // Slightly orange background color
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Log in",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Adjusted size of the image
                  Container(
                    width: 450,
                    height: 355,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          30), // Increased border radius for smoother edges
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          30), // Ensure clipRRect has the same border radius
                      child: Image.asset("assets/pic1.png"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputField(
                    hint: "Username",
                    icon: Icons.account_circle,
                    controller: usrName,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: password,
                    passwordInvisible: true,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    horizontalTitleGap: 2,
                    title: const Text(
                      "Remember me",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    leading: Checkbox(
                      activeColor: primaryColor,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Button(
                    label: "LOG IN",
                    press: () {
                      login();
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  isLoginTrue
                      ? Text(
                          "Username or password is incorrect",
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontSize: 14,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
