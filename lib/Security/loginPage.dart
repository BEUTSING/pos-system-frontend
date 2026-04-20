import 'package:flutter/material.dart';
import 'package:pos_front/Security/registerPage.dart';
import 'package:pos_front/Dashboards/dashboardPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController _emailController = TextEditingController();

final TextEditingController _passwordController = TextEditingController();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  // Dispose of the controllers when the widget is removed from the widget tree
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
       // Allows vertical scrolling
        child: SingleChildScrollView(

          //Allows your interface to be responsive (adapted to mobile, tablet, and web)
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth > 600
                  ? 400
                  : constraints.maxWidth * 0.85;

              return Container(
                 padding: const EdgeInsets.all(20),
                      decoration:BoxDecoration(
                        color: Colors.grey[200], // fond gris
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), 
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), //
                          ),
                        ],
                      ) ,
                child: SizedBox(
                  width: width,
                  child: Column(
                    //
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                
                      const SizedBox(height: 30),
                
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                
                              ),
                              
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                
                            const SizedBox(height: 20),
                
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                              
                              // Validation for password field
                              validator:(values){
                              if(values==null || values.isEmpty){
                                return "Please enter your password";
                              }
                              return null;
                            
                            },
                            ),
                            
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account? "),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text("Create one"),
                                ),
                              ],
                            ),
                              const SizedBox(height: 20),
                
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Login en cours...")),
                                      
                                    );
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardPage(),
                              ),
                            );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  padding: const EdgeInsets.all(15),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}