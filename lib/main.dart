import 'package:flutter/material.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2F5D62),
      ),
      home: const LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
final _formKey = GlobalKey<FormState>();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
bool _obscurePassword = true;
bool _isLoading = false;
@override
void dispose() {
_emailController.dispose();
_passwordController.dispose();
super.dispose();
}
Future<void> _submit() async {
if (!_formKey.currentState!.validate()) return;
setState(() => _isLoading = true);
// Replace this delay with your real authentication call.
await Future.delayed(const Duration(seconds: 1));
if (!mounted) return;
setState(() => _isLoading = false);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Signed in as ${_emailController.text.trim()}')),
);
}
@override
Widget build(BuildContext context) {
final theme = Theme.of(context);
return Scaffold(
body: SafeArea(
child: Center(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(horizontal: 24),
child: ConstrainedBox(
constraints: const BoxConstraints(maxWidth: 400),
child: Form(
key: _formKey,
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Text(
'Welcome back',
style: theme.textTheme.headlineMedium
?.copyWith(fontWeight: FontWeight.bold),
),
const SizedBox(height: 8),
Text(
'Sign in to continue',
style: theme.textTheme.bodyMedium?.copyWith(
color: theme.colorScheme.onSurfaceVariant,
),
),
const SizedBox(height: 32),
TextFormField(
controller: _emailController,
keyboardType: TextInputType.emailAddress,
textInputAction: TextInputAction.next,
decoration: const InputDecoration(
labelText: 'Email',
prefixIcon: Icon(Icons.email_outlined),
border: OutlineInputBorder(),
),
validator: (value) {
final text = value?.trim() ?? '';
if (text.isEmpty) return 'Enter your email';
if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
.hasMatch(text)) {
return 'Enter a valid email address';
}
return null;
},
),
const SizedBox(height: 16),
TextFormField(
controller: _passwordController,
obscureText: _obscurePassword,
textInputAction: TextInputAction.done,
onFieldSubmitted: (_) => _submit(),
decoration: InputDecoration(
labelText: 'Password',
prefixIcon: const Icon(Icons.lock_outline),
border: const OutlineInputBorder(),
suffixIcon: IconButton(
icon: Icon(_obscurePassword
? Icons.visibility_outlined
: Icons.visibility_off_outlined),
onPressed: () => setState(
() => _obscurePassword = !_obscurePassword),
),
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Enter your password';
}
if (value.length < 6) {
return 'Use at least 6 characters';
}
return null;
},
),
Align(
alignment: Alignment.centerRight,
child: TextButton(
onPressed: () {},
child: const Text('Forgot password?'),
),
),
const SizedBox(height: 8),
FilledButton(
onPressed: _isLoading ? null : _submit,
style: FilledButton.styleFrom(
padding: const EdgeInsets.symmetric(vertical: 16),
),
child: _isLoading
? const SizedBox(
height: 20,
width: 20,
child: CircularProgressIndicator(strokeWidth: 2),
)
: const Text('Sign in'),
),
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text("Don't have an account?"),
TextButton(
onPressed: () {},
child: const Text('Create one'),
),
],
),
],
),
),
),
),
),
),
);
}
