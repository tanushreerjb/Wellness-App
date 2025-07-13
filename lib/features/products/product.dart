import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'model/product_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  bool _isLoading = true;
  List<ProductModel> _productList = [];

  void _fetchProduct()async{
    try{
      Response<dynamic> response= await Dio().get(
          'https://dummyjson.com/products'
      );
      if (response.statusCode == 200){
        List<dynamic> dynamicList = response.data['products'];
        _productList = dynamicList
            .map((e) => ProductModel.fromJson(e))
            .toList();
      }
    }catch(e){
      log('fetch product error: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState(){
    _fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Product List')),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            :ListView.builder(
          itemCount: _productList.length,
          itemBuilder: (ctx,index){
            ProductModel productModel = _productList[index];
            return ListTile(
              title: Text('${productModel.title}'),
              subtitle: Text('${productModel.category}'),
            );
          },
        )
    );
  }
}