import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_7/entities/student.dart';
import 'package:flutter_7/service/studentservice.dart';

class AddStudentDialog extends StatefulWidget {
  final Function()? notifyParent;
  final int? formationId;
  final int? classId;
  Student? student;

  AddStudentDialog({
    super.key,
    @required this.notifyParent,
    this.student,
    this.formationId,
    this.classId,
  });

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  TextEditingController nomCtrl = TextEditingController();
  TextEditingController prenomCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String title = "Ajouter Etudiant";
  bool modif = false;
  late int idStudent;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateCtrl.text = DateFormat("yyyy-MM-dd").format(picked);
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      modif = true;
      title = "Modifier Etudiant";
      nomCtrl.text = widget.student!.nom;
      prenomCtrl.text = widget.student!.prenom;
      dateCtrl.text = DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(widget.student!.dateNais));
      idStudent = widget.student!.id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(title),
            TextFormField(
              controller: nomCtrl,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextFormField(
              controller: prenomCtrl,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextFormField(
              controller: dateCtrl,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Date de naissance"),
              onTap: () => _selectDate(context),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (!modif) {
                    final student = Student(
                      dateNais: DateFormat("yyyy-MM-dd").format(selectedDate),
                      nom: nomCtrl.text,
                      prenom: prenomCtrl.text,
                      formationId: widget.formationId,
                      classeId: widget.classId,
                    );

                    await addStudent(student);
                    widget.notifyParent?.call();
                  } else {
                    final student = Student(
                      dateNais: DateFormat("yyyy-MM-dd").format(selectedDate),
                      nom: nomCtrl.text,
                      prenom: prenomCtrl.text,
                      id: idStudent,
                      formationId: widget.formationId,
                      classeId: widget.classId,
                    );

                    await updateStudent(student);
                    widget.notifyParent?.call();
                  }
                  Navigator.pop(context);
                } catch (e) {
                  print('Error saving student: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error saving student: $e')),
                  );
                }
              },
              child: Text(modif ? "Modifier" : "Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}