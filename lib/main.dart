import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/Formulario.dart';
import 'services/firestore_api.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(title: 'Prolins App', home: ProlinsApp()));

class ProlinsApp extends StatelessWidget {
//  Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final String _longitude = '';
  final String _latitude = '';

  final FirestoreApi api = FirestoreApi('contact');

  Future<void> _emailSendAlert(context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Email enviado'),
          content: Text('Email foi enviado com sucesso à Prolins It Solution!'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Formulário de Contato')),
//          backgroundColor: Colors.blue[900],
      ),
//        backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: <Widget>[
                ImageLogo(),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Nome completo',
                  ),
                  controller: _fullNameController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                    ),
                    controller: _emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Telefone'),
                    controller: _telephoneController,
                  ),
                ),
                Container(
                    child: RaisedButton(
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16.0,
                      ),
                      color: Colors.blue[400],
                      onPressed: () async {
                        final String fullNameValue = _fullNameController.text;
                        final String emailValue = _emailController.text;
                        final String telephoneValue = _telephoneController.text;
                        final String latitudeValue = this._latitude;
                        final String longitudeValue = this._longitude;

                        final Formulario newForm = Formulario(
                            fullNameValue,
                            emailValue,
                            telephoneValue,
                            latitudeValue,
                            longitudeValue);

                        final resultForm = newForm.toString();
                        print(resultForm);

//                          Sending Form Data to Firebase
//                          await api.getToken();

//                          await api.addDocument(jsonEncode(newForm));

                        // Sending Email to Prolins using DeepLinking
                        final MailOptions mailOptions = MailOptions(
                          body: 'Novo formulário cadastrado: $resultForm',
                          subject: 'Novo formulário - Prolins It Solution',
                          recipients: ['desafio@prolins.com.br'],
                          isHTML: false,
                          bccRecipients: [],
                          ccRecipients: [],
                          attachments: [],
                        );

                        await FlutterMailer.send(mailOptions);

                        await this._emailSendAlert(context);
                      },
                    ),
                    margin: EdgeInsets.only(top: 32))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.map),
      ),
    );
  }
}

// Separated Container with Image Logo
class ImageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image(
            image: AssetImage('images/prolinsLogo.png'), fit: BoxFit.fill),
      ),
      margin: EdgeInsets.only(bottom: 32),
      height: 180,
      width: 180,
    );
  }
}
