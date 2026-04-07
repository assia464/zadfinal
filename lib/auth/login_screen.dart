import 'package:flutter/material.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

  
    final email = _emailController.text.toLowerCase();
    String route;

    if (email.contains('association') || email.contains('assoc')) {
      route = '/association-home';
    } else if (email.contains('benevole') || email.contains('volunteer')) {
      route = '/benevole-dashboard';
    } else {
      route = '/donateur-home';
    }

    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZADColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              const Text(
                'Se connecter',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: ZADColors.textDark),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🍃', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text('Bienvenue sur ZAD', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: ZADColors.primary)),
                ],
              ),
              const SizedBox(height: 48),
              ZADTextField(
                hint: 'Entrez votre email',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              ZADTextField(
                hint: 'Entrez votre mot de passe',
                icon: Icons.lock_outline,
                obscure: _obscurePassword,
                controller: _passwordController,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                  child: const Text('Mot de passe oublié ?', style: TextStyle(color: ZADColors.linkBlue, fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 40),
              ZADButton(
                label: 'Se connecter',
                onTap: _handleLogin,
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Expanded(child: Divider(color: ZADColors.divider)),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('ou', style: TextStyle(color: ZADColors.textLight))),
                  Expanded(child: Divider(color: ZADColors.divider)),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(color: ZADColors.signupBackground, borderRadius: BorderRadius.circular(16)),
                child: const Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('🍃', style: TextStyle(fontSize: 16)), SizedBox(width: 6), Text('Pas encore de compte ?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700))]),
                    SizedBox(height: 6),
                    Text('Rejoignez ZAD en tant que :', style: TextStyle(fontSize: 14, color: ZADColors.textLight)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ZADButton(
                label: 'Créer un compte',
                onTap: () => Navigator.pushReplacementNamed(context, '/onboarding'),
                outlined: true,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}