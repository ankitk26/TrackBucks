import 'package:flutter/material.dart';
import 'package:trackbucks/config/config.dart';
import 'package:trackbucks/features/auth/business/repositories/auth_repository_impl.dart';
import 'package:trackbucks/features/auth/presentation/screens/export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const path = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final responseMessage = await AuthRepositoryImpl()
          .login(_emailController.text, _passwordController.text);

      if (responseMessage != "ok") {
        messenger.showSnackBar(SnackBar(content: Text(responseMessage)));
      }
    } catch (e) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trackbucks", style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Log in", style: TextStyle(fontSize: 14)),
              const SizedBox(
                height: 40,
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
                  labelText: "Password",
                  labelStyle: const TextStyle(fontSize: 14),
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
                onPressed: () {
                  _handleLogin();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text("Login"),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "Haven't signed up yet?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.path);
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: Palette.primary, fontSize: 14),
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
