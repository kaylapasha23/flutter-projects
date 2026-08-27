import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo - Tugas Dua',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'User Profile Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserModel user;

  @override
  void initState() {
    super.initState();
    
    // Simulasi JSON dari API sesuai Modul Tugas #2 
    // (Data 'id', 'email', dan 'isActive' sengaja tidak dikirim oleh server)
    Map<String, dynamic> jsonResponse = {
      'name': 'Budi Santoso',
      'age': 22,
    };

    // Konversi JSON ke Objek (Aplikasi aman dari crash berkat Null Safety)
    user = UserModel.fromJson(jsonResponse);

    // Print ke Debug Console (Sesuai output yang diminta di modul)
    print('Nama: ${user.name}');      // Output: Budi Santoso
    print('ID: ${user.id}');          // Output: (string kosong)
    print('Status: ${user.isActive}');  // Output: false
    print('To JSON: ${user.toJson()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.account_circle, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 12),
              Text(
                user.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text('ID: ${user.id.isEmpty ? "(string kosong)" : user.id}'),
              Text('Email: ${user.email ?? "-"}'),
              Text('Umur: ${user.age} tahun'),
              Text('Status: ${user.isActive ? "Aktif" : "false"}'),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'To JSON:\n${user.toJson()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'monospace'),
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

class UserModel {
  final String id;
  final String name;
  final String? email;
  final int age;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    required this.age,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown User',
      email: json['email'] as String?,
      age: json['age'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'isActive': isActive,
    };
  }
}