class Commande {
  String numpiece;
  String date;
  String client;
  String etat;
  bool saisie;
  bool commercial;
  bool control1;
  bool control2;
  bool ver;

  Commande({
    required this.numpiece,
    required this.date,
    required this.client,
    required this.etat,
    required this.saisie,
    required this.commercial,
    required this.control1,
    required this.control2,
    required this.ver,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      numpiece: json['numpiece'],
      date: json['date'],
      client: json['client'],
      etat: json['etat'],
      saisie: json['saisie'] == 1,
      commercial: json['commercial'] == 1,
      control1: json['control1'] == 1,
      control2: json['control2'] == 1,
      ver:json['ver'] == 1,
    );
  }
}
