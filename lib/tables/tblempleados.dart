import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmpleadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Empleados',
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
            EmpleadoFormulario(),
            EmpleadoDatos(),
            EmpleadoEditar(),
            EmpleadoBorrar(),
          ],
        ),
      ),
    );
  }
}

class EmpleadoFormulario extends StatefulWidget {
  const EmpleadoFormulario({Key? key}) : super(key: key);

  @override
  _EmpleadoFormularioState createState() => _EmpleadoFormularioState();
}

class _EmpleadoFormularioState extends State<EmpleadoFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idEmpleadoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _ineController = TextEditingController();
  final TextEditingController _rfcController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('empleados').add({
        'id_empleado': _idEmpleadoController.text,
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'direccion': _direccionController.text,
        'telefono': _telefonoController.text,
        'correo': _correoController.text,
        'ine': _ineController.text,
        'rfc': _rfcController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empleado añadido exitosamente')),
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
              controller: _ineController,
              decoration: const InputDecoration(
                labelText: 'INE',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el INE';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _rfcController,
              decoration: const InputDecoration(
                labelText: 'RFC',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el RFC';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Empleado'),
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

class EmpleadoDatos extends StatelessWidget {
  const EmpleadoDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('empleados').snapshots(),
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
                  'ID: ${doc['id_empleado']} - Teléfono: ${doc['telefono']}'),
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

class EmpleadoEditar extends StatelessWidget {
  const EmpleadoEditar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('empleados').snapshots(),
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
              subtitle: Text('ID: ${doc['id_empleado']}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xff8D6E63)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditarEmpleadoDialog(doc: doc),
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

class EditarEmpleadoDialog extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  const EditarEmpleadoDialog({required this.doc});

  @override
  _EditarEmpleadoDialogState createState() => _EditarEmpleadoDialogState();
}

class _EditarEmpleadoDialogState extends State<EditarEmpleadoDialog> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  late TextEditingController _ineController;
  late TextEditingController _rfcController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.doc['nombre']);
    _apellidoController = TextEditingController(text: widget.doc['apellido']);
    _direccionController = TextEditingController(text: widget.doc['direccion']);
    _telefonoController = TextEditingController(text: widget.doc['telefono']);
    _correoController = TextEditingController(text: widget.doc['correo']);
    _ineController = TextEditingController(text: widget.doc['ine']);
    _rfcController = TextEditingController(text: widget.doc['rfc']);
  }

  void _updateEmpleado() {
    FirebaseFirestore.instance
        .collection('empleados')
        .doc(widget.doc.id)
        .update({
      'nombre': _nombreController.text,
      'apellido': _apellidoController.text,
      'direccion': _direccionController.text,
      'telefono': _telefonoController.text,
      'correo': _correoController.text,
      'ine': _ineController.text,
      'rfc': _rfcController.text,
    }).then((_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Empleado actualizado exitosamente')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Empleado'),
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
              controller: _ineController,
              decoration: const InputDecoration(labelText: 'INE'),
            ),
            TextFormField(
              controller: _rfcController,
              decoration: const InputDecoration(labelText: 'RFC'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _updateEmpleado,
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

class EmpleadoBorrar extends StatelessWidget {
  const EmpleadoBorrar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('empleados').snapshots(),
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
              subtitle: Text('ID: ${doc['id_empleado']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: const Text(
                          '¿Está seguro de que desea eliminar este empleado?'),
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
                                .collection('empleados')
                                .doc(doc.id)
                                .delete()
                                .then((_) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Empleado eliminado exitosamente')));
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
