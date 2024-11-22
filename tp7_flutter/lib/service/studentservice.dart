import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter_7/entities/student.dart';

Future getAllStudent() async {
  Response response =
      await http.get(Uri.parse("http://10.0.2.2:8081/etudiant/all"));
  return jsonDecode(response.body);
}

Future deleteStudent(int id) {
  return http
      .delete(Uri.parse("http://10.0.2.2:8081/etudiant/delete?id=${id}"));
}

Future<String> addStudent(Student student) async {
  print('Adding student with data:');
  print(jsonEncode(student.toJson()));  // Debug print

  final response = await http.post(
    Uri.parse("http://10.0.2.2:8081/etudiant/add"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(student.toJson()),
  );

  if (response.statusCode != 200) {
    print('Error response: ${response.body}');  // Debug print
    throw Exception('Failed to add student');
  }

  return response.body;
}

Future updateStudent(Student student) async {
  Response response =
      await http.put(Uri.parse("http://10.0.2.2:8081/etudiant/update"),
          headers: {"Content-type": "Application/json"},
          body: jsonEncode(<String, dynamic>{
            "id": student.id,
            "nom": student.nom,
            "prenom": student.prenom,
            "dateNais": DateFormat("yyyy-MM-dd")
                .format(DateTime.parse(student.dateNais))
          }));
  return response.body;
}
