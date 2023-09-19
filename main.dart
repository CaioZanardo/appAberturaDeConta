import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Desabilita o banner de depuração
      title: 'Formulário de Dados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormularioDados(),
    );
  }
}

class FormularioDados extends StatefulWidget {
  @override
  _FormularioDadosState createState() => _FormularioDadosState();
}

class _FormularioDadosState extends State<FormularioDados> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  String? sexoSelecionado;
  String? escolaridadeSelecionada;
  double limiteConta = 0.0;
  bool brasileiro = false;

  void _exibirDados() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dados da Conta'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nome: ${nomeController.text}'),
              Text('Idade: ${idadeController.text} anos'),
              Text('Sexo: $sexoSelecionado'),
              Text('Escolaridade: $escolaridadeSelecionada'),
              Text('Limite na Conta: R\$ ${limiteConta.toStringAsFixed(2)}'),
              Text('Brasileiro: ${brasileiro ? 'Sim' : 'Não'}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abertura de conta'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // Define a cor de fundo do Scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: idadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Idade'),
              ),
              DropdownButtonFormField<String>(
                value: sexoSelecionado,
                onChanged: (value) {
                  setState(() {
                    sexoSelecionado = value;
                  });
                },
                items: ['Masculino', 'Feminino', 'Outro']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Sexo'),
              ),
              DropdownButtonFormField<String>(
                value: escolaridadeSelecionada,
                onChanged: (value) {
                  setState(() {
                    escolaridadeSelecionada = value;
                  });
                },
                items: ['Fundamental', 'Médio', 'Superior']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Escolaridade'),
              ),
              Text('Limite na Conta: R\$ ${limiteConta.toStringAsFixed(2)}'),
              Slider(
                value: limiteConta,
                onChanged: (value) {
                  setState(() {
                    limiteConta = value;
                  });
                },
                min: 0,
                max: 1000,
                divisions: 50,
              ),
              Row(
                children: [
                  Text('Brasileiro:'),
                  Checkbox(
                    value: brasileiro,
                    onChanged: (value) {
                      setState(() {
                        brasileiro = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _exibirDados,
                child: Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
