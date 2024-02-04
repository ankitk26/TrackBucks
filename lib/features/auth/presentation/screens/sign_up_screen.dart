import 'package:flutter/material.dart';
import 'package:trackbucks/config/config.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const path = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trackbucks", style: TextStyle(fontSize: 16)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Create your account", style: TextStyle(fontSize: 14)),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: "Your Name",
                  labelStyle: const TextStyle(fontSize: 14),
                  hintStyle: TextStyle(color: Palette.secondary),
                  contentPadding: const EdgeInsets.all(
                    14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: "Your Email",
                  labelStyle: const TextStyle(fontSize: 14),
                  hintStyle: TextStyle(color: Palette.secondary),
                  contentPadding: const EdgeInsets.all(
                    14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                cursorColor: Colors.white,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  suffixIcon: _isPasswordVisible
                      ? IconButton(
                          icon: const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = true;
                            });
                          },
                        ),
                  labelText: "Password",
                  labelStyle: const TextStyle(fontSize: 14),
                  helperText:
                      "Click on i button at top for guidance on entering password",
                  helperMaxLines: 2,
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(color: Palette.secondary),
                  contentPadding: const EdgeInsets.all(
                    14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Palette.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text("SIgn up"),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
