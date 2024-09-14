// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class TipCalculatorPage extends StatefulWidget {
  const TipCalculatorPage({super.key});

  @override
  // Crea el estado asociado a TipCalculatorPage.
  _TipCalculatorPageState createState() => _TipCalculatorPageState();
}

class _TipCalculatorPageState extends State<TipCalculatorPage> {
  //Se declaran las variables como tipo double
  double _billAmount = 0.0;
  double _tipPercentage = 0.0;
  double _tipAmount = 0.0;
  double _totalAmount = 0.0;

  // Método que calcula la propina y el total basado en el monto de la cuenta y el porcentaje de propina.
  void _calculateTip() {
    // Verifica si el monto de la cuenta es válido.
    if (_billAmount <= 0) {
      _showErrorMessage(); // Muestra un mensaje de error si el monto menor o igual a 0.
      setState(() {
        //Resetea los montos a 0 si es que se habia calculado antes la propina.
        _tipAmount = 0.0;
        _totalAmount = 0.0;
      });

      return; // Sale del método.
    }

    // Calcula la propina y el total.
    setState(() {
      _tipAmount = (_billAmount * _tipPercentage) / 100; // Calcula la propina.
      _totalAmount = _billAmount + _tipAmount; // Calcula el monto total.
    });
  }

  // Muestra un mensaje de error si el usuario no ha ingresado un monto válido para la cuenta.
  void _showErrorMessage() {
    const snackBar = SnackBar(
      content: Text(
          'Por favor, ingrese el total de la cuenta.'), // Mensaje que se muestra al usuario.
      backgroundColor: Colors.red, // Color de fondo rojo para indicar error.
      behavior:
          SnackBarBehavior.floating, // El Snackbar flota sobre el contenido.
      duration: Duration(seconds: 3), // Duración del mensaje en pantalla.
      margin: EdgeInsets.symmetric(
          horizontal: 16, vertical: 10), // Margen alrededor del mensaje.
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar); // Muestra el Snackbar.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding para todo el contenido.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido.
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 500, // Limita el ancho máximo de la tarjeta.
                  minHeight: MediaQuery.of(context).size.height *
                      0.7, // La tarjeta ocupa al menos el 70% de la altura de la pantalla.
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        24), // Bordes redondeados para la tarjeta.
                  ),
                  elevation: 8, // Sombra alrededor de la tarjeta.
                  child: Padding(
                    padding: const EdgeInsets.all(
                        24.0), // Padding interno de la tarjeta.
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // La columna ocupa solo el espacio necesario.
                      children: [
                        const SizedBox(height: 40), // Espacio vertical.
                        TextField(
                          decoration: const InputDecoration(
                            labelText:
                                'Total de la Cuenta', // Etiqueta del campo de texto.
                            prefixIcon: Icon(Icons
                                .attach_money), // Ícono de moneda en el campo de texto.
                            border:
                                OutlineInputBorder(), // Borde del campo de texto.
                          ),
                          keyboardType: TextInputType
                              .number, // Tipo de teclado para números.
                          onChanged: (value) {
                            setState(() {
                              _billAmount = double.tryParse(value) ??
                                  0.0; // Convierte el valor a double o 0 si es inválido.
                            });
                          },
                        ),
                        const SizedBox(height: 40), // Espacio vertical.
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Distribuye los elementos con espacio entre ellos.
                          children: [
                            const Text(
                                'Porcentaje de Propina:'), // Etiqueta para el dropdown de porcentaje.
                            DropdownButton<double>(
                              value:
                                  _tipPercentage, // Valor seleccionado actualmente.
                              items: [
                                0,
                                10,
                                15,
                                20,
                                25,
                                30
                              ] // Opciones de porcentaje de propina.
                                  .map((percentage) => DropdownMenuItem(
                                        value: percentage
                                            .toDouble(), // Convierte cada porcentaje a double.
                                        child: Text(
                                            '$percentage%'), // Texto mostrado en cada opción.
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _tipPercentage =
                                      value!; // Actualiza el porcentaje de propina seleccionado.
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 40), // Espacio vertical.
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 24.0), // Padding dentro del botón.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Bordes redondeados para el botón.
                            ),
                          ),
                          onPressed:
                              _calculateTip, // Llama al método _calculateTip cuando se presiona el botón.
                          child: const Text(
                              'Calcular Propina'), // Texto del botón.
                        ),
                        const SizedBox(height: 40),
                        Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface), // Línea divisoria.
                        const SizedBox(height: 40),
                        Text(
                          'Propina: \$${_tipAmount.toStringAsFixed(2)}', // Muestra el monto de la propina calculada.
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium, // Estilo de texto.
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Total: \$${_totalAmount.toStringAsFixed(2)}', // Muestra el monto total calculado.
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge, // Estilo de texto.
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
