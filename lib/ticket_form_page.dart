import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'ticket_avion.dart';

class TicketFormPage extends StatefulWidget {
  final TicketAvion? ticket;

  TicketFormPage({this.ticket});

  @override
  _TicketFormPageState createState() => _TicketFormPageState();
}

class _TicketFormPageState extends State<TicketFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String numeroVuelo;
  late String aerolinea;
  late String informacionPasajero;
  late String origen;
  late String destino;
  late String asiento;
  late String clase;

  @override
  void initState() {
    super.initState();
    if (widget.ticket != null) {
      numeroVuelo = widget.ticket!.numeroVuelo;
      aerolinea = widget.ticket!.aerolinea;
      informacionPasajero = widget.ticket!.informacionPasajero;
      origen = widget.ticket!.origen;
      destino = widget.ticket!.destino;
      asiento = widget.ticket!.asiento;
      clase = widget.ticket!.clase;
    } else {
      numeroVuelo = '';
      aerolinea = '';
      informacionPasajero = '';
      origen = '';
      destino = '';
      asiento = '';
      clase = '';
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final firestore = Provider.of<FirebaseFirestore>(context, listen: false);
      final ticket = TicketAvion(
        numeroVuelo: numeroVuelo,
        aerolinea: aerolinea,
        informacionPasajero: informacionPasajero,
        origen: origen,
        destino: destino,
        asiento: asiento,
        clase: clase,
      );

      if (widget.ticket == null) {
        firestore.collection('TicketAvion').add(ticket.toMap());
      } else {
        firestore.collection('TicketAvion').doc(widget.ticket!.id).update(ticket.toMap());
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticket == null ? 'Nuevo Ticket' : 'Editar Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: numeroVuelo,
                decoration: InputDecoration(labelText: 'Número de Vuelo'),
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor ingrese un número de vuelo';
                  return null;
                },
                onSaved: (value) => numeroVuelo = value!,
              ),
              TextFormField(
                initialValue: aerolinea,
                decoration: InputDecoration(labelText: 'Aerolínea'),
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor ingrese una aerolínea';
                  return null;
                },
                onSaved: (value) => aerolinea = value!,
              ),
              TextFormField(
                initialValue: informacionPasajero,
                decoration: InputDecoration(labelText: 'Información del Pasajero'),
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor ingrese información del pasajero';
                  return null;
                },
                onSaved: (value) => informacionPasajero = value!,
              ),
              TextFormField(
                initialValue: origen,
                decoration: InputDecoration(labelText: 'Origen'),
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor ingrese el origen';
                  return null;
                },
                onSaved: (value) => origen = value!,
              ),
              TextFormField(
                initialValue: destino,
                decoration: InputDecoration(labelText: 'Destino'),
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor ingrese el destino';
                  return null;
                },
                onSaved: (value) => destino = value!,
              ),
              TextFormField(
                initialValue: asiento,
                decoration: InputDecoration(labelText: 'Asiento'),
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor ingrese el asiento';
                  return null;
                },
                onSaved: (value) => asiento = value!,
              ),
              TextFormField(
                initialValue: clase,
                decoration: InputDecoration(labelText: 'Clase'),
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor ingrese la clase';
                  return null;
                },
                onSaved: (value) => clase = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
