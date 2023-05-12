import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_authentication/screens/login.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstController = TextEditingController();
    TextEditingController lastController = TextEditingController();

    final email = TextFormField(
      key: const Key('emailField'),
      autovalidateMode: AutovalidateMode.always,
      validator: (input) => input!.isValidEmail() ? null : "Check your email",
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
    );

    final firstName = TextFormField(
      key: const Key('firstField'),
      autovalidateMode: AutovalidateMode.always,
      validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter a first name';
                }
                return null;
      },
      controller: firstController,
      decoration: const InputDecoration(
        hintText: "First name",
      ),
    );

    final lastName = TextFormField(
      key: const Key('lastField'),
      autovalidateMode: AutovalidateMode.always,
      validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
      },
      controller: lastController,
      decoration: const InputDecoration(
        hintText: "Last name",
      ),
    );

    final password = TextFormField(
      key: const Key('pwField'),
            validator: (value){
                if (value == null || value.isEmpty || value.length > 6) {
                  return 'Please make sure your password is at least 6 characters';
                }
                return null;
      },
      autovalidateMode: AutovalidateMode.always,
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
    );

    // ignore: non_constant_identifier_names
    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          
          await context
              .read<AuthProvider>()
              .signUp(emailController.text, passwordController.text);
    
          if (context.mounted) Navigator.pop(context);
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            email,
            password,
            firstName,
            lastName,
            SignupButton,
            backButton
          ],
        ),
      ),
    );
  }
}
