import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PedidosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pedidos',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff8D6E63),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  text: 'Tabla',
                  icon: Icon(Icons.table_chart, color: Colors.white)),
              Tab(text: 'Datos', icon: Icon(Icons.list, color: Colors.white)),
              Tab(text: 'Editar', icon: Icon(Icons.edit, color: Colors.white)),
              Tab(
                  text: 'Borrar',
                  icon: Icon(Icons.delete, color: Colors.white)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PedidoFormulario(),
            PedidoDatos(),
            PedidoEditar(),
            PedidoBorrar(),
          ],
        ),
      ),
    );
  }
}

class PedidoFormulario extends StatefulWidget {
  const PedidoFormulario({Key? key}) : super(key: key);

  @override
  _PedidoFormularioState createState() => _PedidoFormularioState();
}

class _PedidoFormularioState extends State<PedidoFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idPedidoController = TextEditingController();
  final TextEditingController _idClienteController = TextEditingController();
  final TextEditingController _idEmpleadoController = TextEditingController();
  final TextEditingController _fechaPedidoController = TextEditingController();
  final TextEditingController _fechaEntregaController = TextEditingController();
  final TextEditingController _estadoPedidoController = TextEditingController();
  final TextEditingController _metodoPagoController = TextEditingController();
  final TextEditingController _paqueteriaController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('pedidos').add({
        'id_pedido': _idPedidoController.text,
        'id_cliente': _idClienteController.text,
        'id_empleado': _idEmpleadoController.text,
        'fecha_pedido': _fechaPedidoController.text,
        'fecha_entrega': _fechaEntregaController.text,
        'estado_pedido': _estadoPedidoController.text,
        'metodo_pago': _metodoPagoController.text,
        'paqueteria': _paqueteriaController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido añadido exitosamente')),
      );

      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _idPedidoController,
              decoration: const InputDecoration(
                labelText: 'ID Pedido',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del pedido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idClienteController,
              decoration: const InputDecoration(
                labelText: 'ID Cliente',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del cliente';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idEmpleadoController,
              decoration: const InputDecoration(
                labelText: 'ID Empleado',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del empleado';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechaPedidoController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Pedido',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la fecha del pedido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechaEntregaController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Entrega',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la fecha de entrega';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _estadoPedidoController,
              decoration: const InputDecoration(
                labelText: 'Estado del Pedido',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el estado del pedido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _metodoPagoController,
              decoration: const InputDecoration(
                labelText: 'Método de Pago',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el método de pago';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _paqueteriaController,
              decoration: const InputDecoration(
                labelText: 'Paquetería',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la paquetería';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Pedido'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff8D6E63),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PedidoDatos extends StatelessWidget {
  const PedidoDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pedidos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text(
                'Pedido ID: ${doc['id_pedido']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Cliente ID: ${doc['id_cliente']} - Empleado ID: ${doc['id_empleado']}'),
              trailing: Text(doc['estado_pedido']),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}

class PedidoEditar extends StatelessWidget {
  const PedidoEditar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pedidos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text('Pedido ID: ${doc['id_pedido']}'),
              subtitle: Text('Cliente ID: ${doc['id_cliente']}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xff8D6E63)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditarPedidoDialog(doc: doc),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class EditarPedidoDialog extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  const EditarPedidoDialog({required this.doc});

  @override
  _EditarPedidoDialogState createState() => _EditarPedidoDialogState();
}

class _EditarPedidoDialogState extends State<EditarPedidoDialog> {
  late TextEditingController _idClienteController;
  late TextEditingController _idEmpleadoController;
  late TextEditingController _fechaPedidoController;
  late TextEditingController _fechaEntregaController;
  late TextEditingController _estadoPedidoController;
  late TextEditingController _metodoPagoController;
  late TextEditingController _paqueteriaController;

  @override
  void initState() {
    super.initState();
    _idClienteController =
        TextEditingController(text: widget.doc['id_cliente']);
    _idEmpleadoController =
        TextEditingController(text: widget.doc['id_empleado']);
    _fechaPedidoController =
        TextEditingController(text: widget.doc['fecha_pedido']);
    _fechaEntregaController =
        TextEditingController(text: widget.doc['fecha_entrega']);
    _estadoPedidoController =
        TextEditingController(text: widget.doc['estado_pedido']);
    _metodoPagoController =
        TextEditingController(text: widget.doc['metodo_pago']);
    _paqueteriaController =
        TextEditingController(text: widget.doc['paqueteria']);
  }

  void _updatePedido() {
    FirebaseFirestore.instance.collection('pedidos').doc(widget.doc.id).update({
      'id_cliente': _idClienteController.text,
      'id_empleado': _idEmpleadoController.text,
      'fecha_pedido': _fechaPedidoController.text,
      'fecha_entrega': _fechaEntregaController.text,
      'estado_pedido': _estadoPedidoController.text,
      'metodo_pago': _metodoPagoController.text,
      'paqueteria': _paqueteriaController.text,
    }).then((_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pedido actualizado exitosamente')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Pedido'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _idClienteController,
              decoration: const InputDecoration(labelText: 'ID Cliente'),
            ),
            TextFormField(
              controller: _idEmpleadoController,
              decoration: const InputDecoration(labelText: 'ID Empleado'),
            ),
            TextFormField(
              controller: _fechaPedidoController,
              decoration: const InputDecoration(labelText: 'Fecha de Pedido'),
            ),
            TextFormField(
              controller: _fechaEntregaController,
              decoration: const InputDecoration(labelText: 'Fecha de Entrega'),
            ),
            TextFormField(
              controller: _estadoPedidoController,
              decoration: const InputDecoration(labelText: 'Estado del Pedido'),
            ),
            TextFormField(
              controller: _metodoPagoController,
              decoration: const InputDecoration(labelText: 'Método de Pago'),
            ),
            TextFormField(
              controller: _paqueteriaController,
              decoration: const InputDecoration(labelText: 'Paquetería'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _updatePedido,
          child: const Text('Guardar'),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff8D6E63),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

class PedidoBorrar extends StatelessWidget {
  const PedidoBorrar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('pedidos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text('Pedido ID: ${doc['id_pedido']}'),
              subtitle: Text('Cliente ID: ${doc['id_cliente']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text(
                          '¿Está seguro de que desea eliminar este pedido?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('pedidos')
                                .doc(doc.id)
                                .delete()
                                .then((_) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Pedido eliminado exitosamente')));
                            });
                          },
                          child: const Text('Eliminar'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
