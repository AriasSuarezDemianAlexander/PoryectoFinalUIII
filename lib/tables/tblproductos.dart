import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Productos',
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
            ProductoFormulario(),
            ProductoDatos(),
            ProductoEditar(),
            ProductoBorrar(),
          ],
        ),
      ),
    );
  }
}

class ProductoFormulario extends StatefulWidget {
  const ProductoFormulario({Key? key}) : super(key: key);

  @override
  _ProductoFormularioState createState() => _ProductoFormularioState();
}

class _ProductoFormularioState extends State<ProductoFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _unidadController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _detallesController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('productos').add({
        'id_productos': _idController.text,
        'nombre_producto': _nombreController.text,
        'descripcion': _descripcionController.text,
        'stock_disponible': int.tryParse(_stockController.text) ?? 0,
        'unidad_de_medida': _unidadController.text,
        'fecha_de_ingreso': _fechaController.text,
        'detalles': _detallesController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto añadido exitosamente')),
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
              controller: _idController,
              decoration: InputDecoration(
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
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre Producto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre del producto';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _stockController,
              decoration: InputDecoration(
                labelText: 'Stock Disponible',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el stock disponible';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _unidadController,
              decoration: InputDecoration(
                labelText: 'Unidad de Medida',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha de Ingreso',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _detallesController,
              decoration: InputDecoration(
                labelText: 'Detalles',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Producto'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff8D6E63),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
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

class ProductoDatos extends StatelessWidget {
  const ProductoDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('productos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text(
                doc['nombre_producto'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'ID: ${doc['id_productos']} - Stock: ${doc['stock_disponible']}'),
              trailing: Text(doc['unidad_de_medida']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}

class ProductoEditar extends StatelessWidget {
  const ProductoEditar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('productos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text(doc['nombre_producto']),
              subtitle: Text('ID: ${doc['id_productos']}'),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Color(0xff8D6E63)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditarProductoDialog(doc: doc),
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

class EditarProductoDialog extends StatefulWidget {
  final QueryDocumentSnapshot doc;

  const EditarProductoDialog({required this.doc});

  @override
  _EditarProductoDialogState createState() => _EditarProductoDialogState();
}

class _EditarProductoDialogState extends State<EditarProductoDialog> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _stockController;
  late TextEditingController _unidadController;
  late TextEditingController _fechaController;
  late TextEditingController _detallesController;

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.doc['nombre_producto']);
    _descripcionController =
        TextEditingController(text: widget.doc['descripcion']);
    _stockController =
        TextEditingController(text: widget.doc['stock_disponible'].toString());
    _unidadController =
        TextEditingController(text: widget.doc['unidad_de_medida']);
    _fechaController =
        TextEditingController(text: widget.doc['fecha_de_ingreso']);
    _detallesController = TextEditingController(text: widget.doc['detalles']);
  }

  void _updateProduct() {
    FirebaseFirestore.instance
        .collection('productos')
        .doc(widget.doc.id)
        .update({
      'nombre_producto': _nombreController.text,
      'descripcion': _descripcionController.text,
      'stock_disponible': int.tryParse(_stockController.text) ?? 0,
      'unidad_de_medida': _unidadController.text,
      'fecha_de_ingreso': _fechaController.text,
      'detalles': _detallesController.text,
    }).then((_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto actualizado exitosamente')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Producto'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre Producto'),
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextFormField(
              controller: _stockController,
              decoration: InputDecoration(labelText: 'Stock Disponible'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _unidadController,
              decoration: InputDecoration(labelText: 'Unidad de Medida'),
            ),
            TextFormField(
              controller: _fechaController,
              decoration: InputDecoration(labelText: 'Fecha de Ingreso'),
              keyboardType: TextInputType.datetime,
            ),
            TextFormField(
              controller: _detallesController,
              decoration: InputDecoration(labelText: 'Detalles'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _updateProduct,
          child: Text('Guardar'),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff8D6E63),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
      ],
    );
  }
}

class ProductoBorrar extends StatelessWidget {
  const ProductoBorrar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('productos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text(doc['nombre_producto']),
              subtitle: Text('ID: ${doc['id_productos']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirmar eliminación'),
                      content: Text(
                          '¿Está seguro de que desea eliminar este producto?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('productos')
                                .doc(doc.id)
                                .delete()
                                .then((_) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Producto eliminado exitosamente')));
                            });
                          },
                          child: Text('Eliminar'),
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
