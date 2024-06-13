import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clientes',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff8D6E63),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Tabla', icon: Icon(Icons.edit, color: Colors.white)),
              Tab(text: 'Datos', icon: Icon(Icons.list, color: Colors.white)),
              Tab(
                  text: 'Editar',
                  icon: Icon(Icons.edit_attributes, color: Colors.white)),
              Tab(
                  text: 'Borrar',
                  icon: Icon(Icons.delete, color: Colors.white)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ClienteFormulario(),
            ClienteDatos(),
            ClienteEditar(),
            ClienteBorrar(),
          ],
        ),
      ),
    );
  }
}

class ClienteFormulario extends StatefulWidget {
  const ClienteFormulario({Key? key}) : super(key: key);

  @override
  _ClienteFormularioState createState() => _ClienteFormularioState();
}

class _ClienteFormularioState extends State<ClienteFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idClienteController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _fechaRegistroController =
      TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('clientes').add({
        'id_cliente': _idClienteController.text,
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'direccion': _direccionController.text,
        'telefono': _telefonoController.text,
        'correo': _correoController.text,
        'fecha_registro': _fechaRegistroController.text,
        'codigo_postal': _codigoPostalController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente añadido exitosamente')),
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
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el apellido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _direccionController,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la dirección';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el teléfono';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _correoController,
              decoration: const InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el correo';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechaRegistroController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Registro',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la fecha de registro';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _codigoPostalController,
              decoration: const InputDecoration(
                labelText: 'Código Postal',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el código postal';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Cliente'),
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

class ClienteDatos extends StatelessWidget {
  const ClienteDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('clientes').snapshots(),
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
                '${doc['nombre']} ${doc['apellido']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'ID: ${doc['id_cliente']} - Teléfono: ${doc['telefono']}'),
              trailing: Text(doc['correo']),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}

class ClienteEditar extends StatelessWidget {
  const ClienteEditar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('clientes').snapshots(),
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
              title: Text('${doc['nombre']} ${doc['apellido']}'),
              subtitle: Text('ID: ${doc['id_cliente']}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xff8D6E63)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditarClienteDialog(doc: doc),
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

class EditarClienteDialog extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  const EditarClienteDialog({required this.doc});

  @override
  _EditarClienteDialogState createState() => _EditarClienteDialogState();
}

class _EditarClienteDialogState extends State<EditarClienteDialog> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  late TextEditingController _fechaRegistroController;
  late TextEditingController _codigoPostalController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.doc['nombre']);
    _apellidoController = TextEditingController(text: widget.doc['apellido']);
    _direccionController = TextEditingController(text: widget.doc['direccion']);
    _telefonoController = TextEditingController(text: widget.doc['telefono']);
    _correoController = TextEditingController(text: widget.doc['correo']);
    _fechaRegistroController =
        TextEditingController(text: widget.doc['fecha_registro']);
    _codigoPostalController =
        TextEditingController(text: widget.doc['codigo_postal']);
  }

  void _updateClient() {
    FirebaseFirestore.instance
        .collection('clientes')
        .doc(widget.doc.id)
        .update({
      'nombre': _nombreController.text,
      'apellido': _apellidoController.text,
      'direccion': _direccionController.text,
      'telefono': _telefonoController.text,
      'correo': _correoController.text,
      'fecha_registro': _fechaRegistroController.text,
      'codigo_postal': _codigoPostalController.text,
    }).then((_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente actualizado exitosamente')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Cliente'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: _direccionController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _correoController,
              decoration: const InputDecoration(labelText: 'Correo'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _fechaRegistroController,
              decoration: const InputDecoration(labelText: 'Fecha de Registro'),
              keyboardType: TextInputType.datetime,
            ),
            TextFormField(
              controller: _codigoPostalController,
              decoration: const InputDecoration(labelText: 'Código Postal'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _updateClient,
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

class ClienteBorrar extends StatelessWidget {
  const ClienteBorrar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('clientes').snapshots(),
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
              title: Text('${doc['nombre']} ${doc['apellido']}'),
              subtitle: Text('ID: ${doc['id_cliente']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text(
                          '¿Está seguro de que desea eliminar este cliente?'),
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
                                .collection('clientes')
                                .doc(doc.id)
                                .delete()
                                .then((_) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Cliente eliminado exitosamente')));
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
