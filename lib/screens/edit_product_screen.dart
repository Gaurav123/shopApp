import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
 final _priceFocusNode = FocusNode();
 final _discription = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();


 @override
  void initState() {
   _imageUrlFocusNode.addListener(() {_updateImageUrl;});
    super.initState();
  }

  void _updateImageUrl(){
   if(_imageUrlFocusNode.hasFocus){
     setState(() {

     });
   }

  }

  void dispose(){
   _imageUrlFocusNode.dispose();
   _imageController.dispose();
   _priceFocusNode.dispose();
   _discription.dispose();
   _imageUrlFocusNode.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Product'
        ),
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_priceFocusNode);
            },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_discription);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Discription',),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
            focusNode: _discription,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 8,right: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey
                  )),
                  child: _imageController.text.isEmpty?
                  Text('Enter a URL'):
                  FittedBox(
                    child: Image.network(
                      _imageController.text,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageController,
                 focusNode: _imageUrlFocusNode,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
