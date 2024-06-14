import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetallesPedidoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detalles del Pedido',
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
            DetallesPedidoFormulario(),
            DetallesPedidoDatos(),
            DetallesPedidoEditar(),
            DetallesPedidoBorrar(),
          ],
        ),
      ),
    );
  }
}

class DetallesPedidoFormulario extends StatefulWidget {
  const DetallesPedidoFormulario({Key? key}) : super(key: key);

  @override
  _DetallesPedidoFormularioState createState() =>
      _DetallesPedidoFormularioState();
}

class _DetallesPedidoFormularioState extends State<DetallesPedidoFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idDetallesPedidoController =
      TextEditingController();
  final TextEditingController _idPedidoController = TextEditingController();
  final TextEditingController _idProductoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _subtotalController = TextEditingController();
  final TextEditingController _descuentoController = TextEditingController();
  final TextEditingController _ivaController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('detalles_del_pedido').add({
        'id_detallespedido': _idDetallesPedidoController.text,
        'id_pedido': _idPedidoController.text,
        'id_producto': _idProductoController.text,
        'cantidad': _cantidadController.text,
        'precio': _precioController.text,
        'subtotal': _subtotalController.text,
        'descuento': _descuentoController.text,
        'iva': _ivaController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Detalle del pedido añadido exitosamente')),
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
              controller: _idDetallesPedidoController,
              decoration: const InputDecoration(
                labelText: 'ID Detalles Pedido',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID de los detalles del pedido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
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
              controller: _idProductoController,
              decoration: const InputDecoration(
                labelText: 'ID Producto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del producto';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _cantidadController,
              decoration: const InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la cantidad';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _precioController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el precio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _subtotalController,
              decoration: const InputDecoration(
                labelText: 'Subtotal',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el subtotal';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descuentoController,
              decoration: const InputDecoration(
                labelText: 'Descuento',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el descuento';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _ivaController,
              decoration: const InputDecoration(
                labelText: 'IVA',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el IVA';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Detalle del Pedido'),
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

class DetallesPedidoDatos extends StatelessWidget {
  const DetallesPedidoDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('detalles_del_pedido')
          .snapshots(),
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
                'Detalle Pedido ID: ${doc['id_detallespedido']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Pedido ID: ${doc['id_pedido']} - Producto ID: ${doc['id_producto']}'),
              trailing: Text('Cantidad: ${doc['cantidad']}'),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}

class DetallesPedidoEditar extends StatelessWidget {
  const DetallesPedidoEditar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('detalles_del_pedido')
          .snapshots(),
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
              title: Text('Detalle Pedido ID: ${doc['id_detallespedido']}'),
              subtitle: Text(
                  'Pedido ID: ${doc['id_pedido']} - Producto ID: ${doc['id_producto']}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xff8D6E63)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditarDetallesPedidoDialog(doc: doc),
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

class EditarDetallesPedidoDialog extends StatefulWidget {
  final DocumentSnapshot doc;

  const EditarDetallesPedidoDialog({Key? key, required this.doc})
      : super(key: key);

  @override
  _EditarDetallesPedidoDialogState createState() =>
      _EditarDetallesPedidoDialogState();
}

class _EditarDetallesPedidoDialogState
    extends State<EditarDetallesPedidoDialog> {
  late TextEditingController _idDetallesPedidoController;
  late TextEditingController _idPedidoController;
  late TextEditingController _idProductoController;
  late TextEditingController _cantidadController;
  late TextEditingController _precioController;
  late TextEditingController _subtotalController;
  late TextEditingController _descuentoController;
  late TextEditingController _ivaController;

  @override
  void initState() {
    super.initState();
    _idDetallesPedidoController =
        TextEditingController(text: widget.doc['id_detallespedido']);
    _idPedidoController = TextEditingController(text: widget.doc['id_pedido']);
    _idProductoController =
        TextEditingController(text: widget.doc['id_producto']);
    _cantidadController = TextEditingController(text: widget.doc['cantidad']);
    _precioController = TextEditingController(text: widget.doc['precio']);
    _subtotalController = TextEditingController(text: widget.doc['subtotal']);
    _descuentoController = TextEditingController(text: widget.doc['descuento']);
    _ivaController = TextEditingController(text: widget.doc['iva']);
  }

  void _updateDetallesPedido() {
    FirebaseFirestore.instance
        .collection('detalles_del_pedido')
        .doc(widget.doc.id)
        .update({
      'id_detallespedido': _idDetallesPedidoController.text,
      'id_pedido': _idPedidoController.text,
      'id_producto': _idProductoController.text,
      'cantidad': _cantidadController.text,
      'precio': _precioController.text,
      'subtotal': _subtotalController.text,
      'descuento': _descuentoController.text,
      'iva': _ivaController.text,
    }).then((_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Detalle del pedido actualizado exitosamente')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Detalle del Pedido'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _idDetallesPedidoController,
              decoration:
                  const InputDecoration(labelText: 'ID Detalles Pedido'),
            ),
            TextFormField(
              controller: _idPedidoController,
              decoration: const InputDecoration(labelText: 'ID Pedido'),
            ),
            TextFormField(
              controller: _idProductoController,
              decoration: const InputDecoration(labelText: 'ID Producto'),
            ),
            TextFormField(
              controller: _cantidadController,
              decoration: const InputDecoration(labelText: 'Cantidad'),
            ),
            TextFormField(
              controller: _precioController,
              decoration: const InputDecoration(labelText: 'Precio'),
            ),
            TextFormField(
              controller: _subtotalController,
              decoration: const InputDecoration(labelText: 'Subtotal'),
            ),
            TextFormField(
              controller: _descuentoController,
              decoration: const InputDecoration(labelText: 'Descuento'),
            ),
            TextFormField(
              controller: _ivaController,
              decoration: const InputDecoration(labelText: 'IVA'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _updateDetallesPedido,
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

class DetallesPedidoBorrar extends StatelessWidget {
  const DetallesPedidoBorrar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('detalles_del_pedido')
          .snapshots(),
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
              title: Text('Detalle Pedido ID: ${doc['id_detallespedido']}'),
              subtitle: Text(
                  'Pedido ID: ${doc['id_pedido']} - Producto ID: ${doc['id_producto']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text(
                          '¿Está seguro de que desea eliminar este detalle del pedido?'),
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
                                .collection('detalles_del_pedido')
                                .doc(doc.id)
                                .delete()
                                .then((_) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Detalle del pedido eliminado exitosamente')));
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
