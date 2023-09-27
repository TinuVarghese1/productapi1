import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String title;
  final String category;
  final String brand;
  final String description;
  final double price;
  final String imageUrl;

  ProductDetailsPage({
    required this.title,
    required this.category,
    required this.brand,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 450,
          color: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0),
              Center(child: Image.network(imageUrl, width: 300,)),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0), // Add spacing
                    Text('Category: $category'),
                    SizedBox(height: 8.0), // Add spacing
                    Text('Brand: $brand'),
                    SizedBox(height: 8.0), // Add spacing
                    Text('Description: $description'),
                    SizedBox(height: 8.0), // Add spacing
                    Text('Price: \$${price.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the "Add to Cart" button action here
                  },
                  child: Text('Add '),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
