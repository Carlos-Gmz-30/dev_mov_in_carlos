import 'package:flutter/material.dart';

class Student {
  final String name;
  final String matricula;
  Student(this.name, this.matricula);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Estudiantes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lista de Estudiantes'),
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
  final List<Student> students = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();

  void _addStudent() {
    final name = _nameController.text.trim();
    final matricula = _matriculaController.text.trim();

    if (name.isEmpty || matricula.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ningún campo puede estar vacío")),
      );
      return;
    }

    setState(() {
      students.add(Student(name, matricula));
    });
    _nameController.clear();
    _matriculaController.clear();
  }

  Widget _buildStudentList() {
    if (students.isEmpty) {
      return const Text("No hay estudiantes agregados.");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: students
          .map((student) => Text("- ${student.name} (${student.matricula})"))
          .toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _matriculaController,
              decoration: const InputDecoration(
                labelText: "Matrícula",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addStudent,
              child: const Text("Agregar Estudiante"),
            ),
            const SizedBox(height: 24),
            const Text(
              "Lista de estudiantes:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildStudentList(),
          ],
        ),
      ),
    );
  }
}
