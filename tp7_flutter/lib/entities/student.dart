class Student {
  final String dateNais;
  final String nom;
  final String prenom;
  final int? id;
  final int? formationId;
  final int? classeId;

  Student({
    required this.dateNais,
    required this.nom,
    required this.prenom,
    this.id,
    this.formationId,
    this.classeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'dateNais': dateNais,
      'formation': formationId != null ? {'id': formationId} : null,
      'classe': classeId != null ? {'codClass': classeId} : null,
      if (id != null) 'id': id,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      dateNais: json['dateNais'],
      formationId: json['formation']?['id'],
      classeId: json['classe']?['codClass'],
    );
  }
}