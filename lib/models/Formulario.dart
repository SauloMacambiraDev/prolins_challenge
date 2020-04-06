import 'dart:convert';

class Formulario {
  final String fullName;
  final String email;
  final String telephone;
  final String latitude;
  final String longitude;

  const Formulario(
      this.fullName, this.email, this.telephone, this.latitude, this.longitude);

  @override
  String toString() {
    // TODO: implement toString
    return 'Form{ fullName: $fullName, email: $email, telephone: $telephone, latitude: $latitude, longitude: $longitude';
  }

  Map toJSON() {
    return {
      'fullName': this.fullName,
      'email': this.email,
      'telephone': this.telephone,
      'latitude': this.latitude,
      'longitude': this.longitude
    };
  }
}
