import 'package:flutter/material.dart';

class Producto {
  final String imagenUrl;
  final String nombre;
  final double precio;

  Producto({
    required this.imagenUrl,
    required this.nombre,
    required this.precio,
  });
}

class ProductosPagee extends StatelessWidget {
  final List<Producto> productos = [
    Producto(
      imagenUrl:
          "https://raw.githubusercontent.com/AriasSuarezDemianAlexander/IMGFlutlabCarpinteria/main/iconC.jpg",
      nombre: "Mesa de madera",
      precio: 150.0,
    ),
    Producto(
      imagenUrl:
          "https://raw.githubusercontent.com/AriasSuarezDemianAlexander/IMGFlutlabCarpinteria/main/iconC.jpg",
      nombre: "Silla de roble",
      precio: 80.0,
    ),
    Producto(
      imagenUrl:
          "https://raw.githubusercontent.com/AriasSuarezDemianAlexander/IMGFlutlabCarpinteria/main/iconC.jpg",
      nombre: "Armario de pino",
      precio: 250.0,
    ),
    Producto(
      imagenUrl:
          "https://raw.githubusercontent.com/AriasSuarezDemianAlexander/IMGFlutlabCarpinteria/main/iconC.jpg",
      nombre: "Estantería de cerezo",
      precio: 120.0,
    ),
    Producto(
      imagenUrl:
          "https://raw.githubusercontent.com/AriasSuarezDemianAlexander/IMGFlutlabCarpinteria/main/iconC.jpg",
      nombre: "Mesa de centro",
      precio: 90.0,
    ),
    Producto(
      imagenUrl:
          "https://raw.githubusercontent.com/AriasSuarezDemianAlexander/IMGFlutlabCarpinteria/main/iconC.jpg",
      nombre: "Silla de escritorio",
      precio: 60.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return ProductoCard(producto: productos[index]);
        },
      ),
    );
  }
}

class ProductoCard extends StatelessWidget {
  final Producto producto;

  ProductoCard({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            producto.imagenUrl,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              producto.nombre,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${producto.precio.toString()}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
