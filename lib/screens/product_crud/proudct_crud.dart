import 'local_utils/category_picker_bloc.dart';
import 'local_utils/dropdown_brand_bloc.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/utils/generate_filename_image.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/multiple_image_pick_bloc.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/multi_image_picker.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/title_description_form.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/input_custom_decoration.dart';
import 'dart:io';

class ProductCrud extends StatelessWidget {
  MultipleImagePickBloc _multipleImagePickBloc = MultipleImagePickBloc();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  DropdownBrandBloc _dropdownBrandBloc = DropdownBrandBloc();
  CategoryPickerBloc _categoryPickerBloc = CategoryPickerBloc();
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  ProductModel productModel;

  ProductCrud({model}) {
    if (model != null) {
      this.productModel = model;

      this.productModel.images.forEach((e) => _multipleImagePickBloc.add(e));
      this.productModel.categories.forEach((e) => _categoryPickerBloc.add(e));
      _dropdownBrandBloc.add(this.productModel.brand);
      _titleController.value = TextEditingValue(text: this.productModel.name);
      _descriptionController.value = TextEditingValue(
        text: this.productModel.description,
      );
      _priceController.value =
          TextEditingValue(text: this.productModel.price.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          ScreenPadding,
          ScreenPadding,
          ScreenPadding,
          0,
        ),
        children: [
          Title(productModel == null ? 'Add product' : 'Edit product'),
          SizedBox(height: 30),
          ImageRow(bloc: _multipleImagePickBloc),
          _categoryBrandSelect(context),
          SizedBox(height: 30),
          TitleDescriptionForm(
            name: 'Product',
            titleController: _titleController,
            descriptionController: _descriptionController,
          ),
          SizedBox(height: 30),
          priceField(),
          SizedBox(height: 30),
          actionButtons(context),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget priceField() {
    return Container(
      child: Column(
        children: [
          Row(children: [Text('Price', style: ProductInfoTitle)]),
          SizedBox(height: ScreenPadding),
          inputCustomDeocration(
            TextField(
              keyboardType: TextInputType.number,
              smartDashesType: SmartDashesType.enabled,
              maxLines: 1,
              controller: _priceController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryBrandSelect(BuildContext context) {
    return Container(
      height: 60,
      child: Center(
        child: Container(
          height: 60,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/selectCategoryAndBrand',
                arguments: {
                  'dropdownBrandBloc': _dropdownBrandBloc,
                  'categoryPickerBloc': _categoryPickerBloc,
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text('Select brand or category'),
            ),
          ),
        ),
      ),
    );
  }

  Widget Title(String title) {
    return SizedBox(
      height: 50,
      child: UnderlinedText(title).noUnderline(),
    );
  }

  Widget actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RaisedButton(
          color: DefaultGreenColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed:
              productModel == null ? () => _save(context) : () => _update(),
          child: Text(productModel == null ? 'Save' : 'Update'),
        ),
        RaisedButton(
          color: DefaultRedColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed:
              productModel == null ? () => Navigator.pop(context) : _delete,
          child: Text(
            productModel == null ? 'Cancel' : 'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future _update() async {
    if (validate() != 1) return 0;

    showDialog(
      barrierDismissible: false,
      context: _globalKey.currentContext,
      child: Center(child: CircularProgressIndicator()),
    );

    ProductModel productModel = ProductModel();
    productModel.name = _titleController.value.text;
    productModel.description = _descriptionController.value.text;
    productModel.brand = _dropdownBrandBloc.currValue;
    productModel.categories = _categoryPickerBloc.categoriesPicked;
    productModel.id = this.productModel.id;
    productModel.price = double.parse(_priceController.value.text);

    List<String> localPaths = _multipleImagePickBloc.paths
        .where((e) => !e.contains('https://'))
        .toList();

    List<String> urls = _multipleImagePickBloc.paths
        .where((e) => e.contains('https://'))
        .toList();

    if (localPaths.length > 0) {
      // Uploading images
      List<Future> imageUploadFutures = localPaths.map((e) {
        return FirebaseStorageApi.uploadFile(
          file: File(e),
          filename: generateFilename(e),
        );
      }).toList();

      List uploadedUrls = await Future.wait(imageUploadFutures);
      urls.addAll(uploadedUrls.cast<String>());
    }

    productModel.images = urls.cast<String>();

    await FirebaseStorageApi.updateDocument(
      collection: 'products',
      model: productModel.toJson(),
    );

    Navigator.pushReplacementNamed(_globalKey.currentContext, '/');
  }

  Future _delete() async {
    showDialog(
      barrierDismissible: false,
      context: _globalKey.currentContext,
      child: Center(child: CircularProgressIndicator()),
    );

    await FirebaseStorageApi.deleteDoc(
      collection: 'products',
      id: productModel.id,
    );

    Navigator.pushReplacementNamed(_globalKey.currentContext, '/');
  }

  Future _save(context) async {
    if (validate() != 1) return 0;

    showDialog(
      barrierDismissible: false,
      context: context,
      child: Center(child: CircularProgressIndicator()),
    );

    ProductModel productModel = ProductModel();
    productModel.name = _titleController.value.text;
    productModel.description = _descriptionController.value.text;
    productModel.brand = _dropdownBrandBloc.currValue;
    productModel.categories = _categoryPickerBloc.categoriesPicked;
    productModel.price = double.parse(_priceController.value.text);

    // Uploading images
    List<Future> imageUploadFutures = _multipleImagePickBloc.paths.map((e) {
      return FirebaseStorageApi.uploadFile(
        file: File(e),
        filename: generateFilename(e),
      );
    }).toList();

    List urls = await Future.wait(imageUploadFutures);

    productModel.images = urls.cast<String>();

    print(productModel.toJson());

    await FirebaseStorageApi.addData(
      data: productModel.toJson(),
      collection: 'products',
    );

    Navigator.pushReplacementNamed(context, '/');
  }

  void showValidationMsg({String message}) {
    _globalKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: DefaultRedColor,
        content: Text(message),
      ),
    );
  }

  int validate() {
    if (_multipleImagePickBloc.paths.length < 1) {
      showValidationMsg(message: 'Add minimum of 3 product images');
      return 0;
    }

    if (_dropdownBrandBloc.currValue == null) {
      showValidationMsg(message: 'Select a brand for this product');
      return 0;
    }

    if (_categoryPickerBloc.categoriesPicked.length < 1) {
      showValidationMsg(message: 'Select category for this product');
      return 0;
    }

    if (_titleController.value.text.length < 1) {
      showValidationMsg(message: 'Add product title');
      return 0;
    }

    if (_descriptionController.value.text.length < 1) {
      showValidationMsg(message: 'Add product description');
      return 0;
    }

    if (_priceController.value.text.length < 1) {
      showValidationMsg(message: 'Add product price');
      return 0;
    }

    if (double.tryParse(_priceController.value.text) == null) {
      showValidationMsg(message: 'Invalid price');
      return 0;
    }

    return 1;
  }
}
