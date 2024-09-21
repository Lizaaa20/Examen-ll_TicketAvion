import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'ticket_form_page.dart';
import 'ticket_avion.dart';

class TicketListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirebaseFirestore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets de Avión'),
      ),
      body: StreamBuilder(
        stream: firestore.collection('TicketAvion').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final tickets = snapshot.data!.docs.map((doc) => TicketAvion.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
          
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return ListTile(
                title: Text(ticket.numeroVuelo),
                subtitle: Text('${ticket.origen} -> ${ticket.destino}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketFormPage(ticket: ticket),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    firestore.collection('TicketAvion').doc(ticket.id).delete();
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
