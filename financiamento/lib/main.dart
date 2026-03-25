import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simulador',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const SimuladorPage(),
    );
  }
}

class SimuladorPage extends StatefulWidget {
  const SimuladorPage({super.key});

  @override
  State<SimuladorPage> createState() => _SimuladorPageState();
}

class _SimuladorPageState extends State<SimuladorPage> {
  final valorController = TextEditingController();
  final jurosController = TextEditingController();
  final parcelasController = TextEditingController();
  final taxasController = TextEditingController();

  double total = 0;
  double parcela = 0;

  void calcular() {
    double valor = double.tryParse(valorController.text) ?? 0;
    double juros = double.tryParse(jurosController.text) ?? 0;
    int parcelas = int.tryParse(parcelasController.text) ?? 0;
    double taxas = double.tryParse(taxasController.text) ?? 0;

    juros = juros / 100;

    if (parcelas > 0) {
      double jurosTotal = valor * juros * parcelas;
      total = valor + jurosTotal + taxas;
      parcela = total / parcelas;
    }

    setState(() {});

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Resultado"),
        content: Text(
          "Valor total a ser pago: R\$ ${total.toStringAsFixed(2)}\n"
          "Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget campo(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Simulador de Financiamento",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 55, 38, 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Valor do financiamento",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            campo("Digite o valor", valorController),
            Text(
              "Taxa de juros ao mês (%)",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            campo("Digite a taxa de juros", jurosController),
            Text(
              "Número de parcelas",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            campo("Digite o números de parcelas", parcelasController),
            Text(
              "Demais taxas e custos",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            campo("Digite o total de taxas ou custos adicionais", taxasController),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 55, 38, 32),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: calcular,
              child: const Text("Calcular", style: TextStyle(color: Colors.white),),
            ),

            const SizedBox(height: 20),

            Text(
              "Valor total a ser pago: R\$ ${total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
