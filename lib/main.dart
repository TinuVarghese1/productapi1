import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:productapi1/model/Product.dart';
import 'package:productapi1/model/Products.dart';
import 'package:productapi1/product_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),

    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future<List<Products>?> getProducts() async

    {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/products'));
      if(response.statusCode==200)
      {
        var jsondata = json.decode(response.body.toString());
        var res=Product.fromJson(jsondata);
        var datalist=res.products;
        return datalist;
      }
      else
      {
        throw Exception("unable to load data");
      }
    }
    return Scaffold(

      appBar: AppBar(),
      body:
        FutureBuilder(
            future: getProducts(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var Productlist=snapshot.data as List<Products>;
                return ListView.builder(
                    itemCount: Productlist.length,
                    itemBuilder: (BuildContext context,int index){
                      // return Column(children: [
                      //   Text('${Productlist[index].id}'),
                      //   Text('${Productlist[index].brand}'),
                      //   Text('${Productlist[index].category}'),
                      //   Image.network('${Productlist[index].thumbnail}'),
                      // ],);

                      return InkWell(

                        onTap: () {

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                title: Productlist[index].title!,
                                category: Productlist[index].category!,
                                brand: Productlist[index].brand!,
                                description: Productlist[index].description!,

                                imageUrl: Productlist[index].thumbnail!,
                                price: (Productlist[index].price as num).toDouble(),
                              ),
                            ),
                          );
                        },



                        child: Container(
                          height: 200,
                          width: 50,
                          

                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              Positioned(child: Image.network('${Productlist[index].thumbnail}',width: 200,),
                             ),

                              Positioned(
                                top: 4.0,
                                left: 4.0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  color: Colors.red,
                                  child: Text(
                                    '${Productlist[index].discountPercentage}% OFF',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),


                              Positioned(
                                bottom: 10.0,
                                left: 10.0,
                                child: Text(
                                  'Price: \$${Productlist[index].price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),


                              Positioned(
                                bottom: 10.0,
                                right: 70.0,
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),

                                    Text(
                                      '${Productlist[index].rating}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10.0,
                                left: 120.0,
                                right: 10.0,
                                child: Text(
                                  '${Productlist[index].title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),




                            ],
                          ),

                        ),
                      );

                    });
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }
        ),


    );
  }
}


