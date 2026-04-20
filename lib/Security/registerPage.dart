import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pos_front/Dashboards/dashboardPage.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  // CONTROLLERS

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
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
              width: 400,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
            
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
            
                    const SizedBox(height: 30),
            
                    // NAME
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your name";
                        }
                        return null;
                      },
                    ),
            
                    const SizedBox(height: 20),
                       
                    // EMAIL
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your email";
                        }
                        else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return "Invalid email format";
                        }
                        return null;
                      },
                    ),
            
                    const SizedBox(height: 20),
            
                     // PHONE
            
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your phone number";
                        }
                        if (value.length < 9) {
                          return "Invalid phone number";
                        }
                        return null;
                      },
                    ),
            
                    const SizedBox(height: 20),
            
                    // CITY
                    TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(
                        labelText: "City",
                        prefixIcon: Icon(Icons.location_city),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your city";
                        }
                        return null;
                      },
                    ),
            
                    const SizedBox(height: 20),
                    // PASSWORD
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your password";
                        }
                        else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
            
                    const SizedBox(height: 30),
            
                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
            
                            // 👉 After successful registration go to dashboard
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardPage(),
                              ),
                            );
                          }
                        },
                        child: const Text("Create Account"),
                      ),
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
}