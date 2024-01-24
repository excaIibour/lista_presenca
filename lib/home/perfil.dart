import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('assets/images/me.jpg'),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(
              width: 250,
              child: Text('Oi! Eu sou a Joseane! :) Sou Desenvolvedora de Software desde 2022, apaixonada por mudar a vida das pessoas através do Flutter. Quer me conhecer mais? Bora bater um papo!', textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () async {
                Uri url = Uri.parse('https://www.linkedin.com/in/joseane-vieira-ba25a2217');
                if (await launchUrl(url)) {
                  throw 'Não foi possível abrir $url';
                }
              },
              icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue),
              label: const Text('LinkedIn', style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () async {
                Uri url = Uri.parse('https://github.com/excaIibour');
                if (await launchUrl(url)) {
                  throw 'Não foi possível abrir $url';
                }
              },
              icon: const FaIcon(FontAwesomeIcons.github, color: Colors.purple),
              label: const Text('GitHub', style: TextStyle(color: Colors.purple)),
            ),
          ],
        ),
      ),
    );
  }
}
