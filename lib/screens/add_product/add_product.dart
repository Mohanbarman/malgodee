import 'package:ShoppingApp/screens/add_product/local_utils/category_picker_bloc.dart';
import 'package:ShoppingApp/screens/add_product/local_utils/dropdown_brand_bloc.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/multiple_image_pick_bloc.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/multi_image_picker.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/title_description_form.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';

class AddProduct extends StatelessWidget {
  MultipleImagePickBloc _multipleImagePickBloc = MultipleImagePickBloc();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DropdownBrandBloc _dropdownBrandBloc = DropdownBrandBloc();
  CategoryPickerBloc _categoryPickerBloc = CategoryPickerBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Title('Add product'),
          SizedBox(height: 30),
          Text('Product images', style: AddFieldLabelStyle),
          SizedBox(height: 30),
          ImageRow(bloc: _multipleImagePickBloc),
          SizedBox(height: 60),
          _categoryBrandSelect(context),
          SizedBox(height: 30),
          TitleDescriptionForm(
            name: 'Product',
            titleController: _titleController,
            descriptionController: _descriptionController,
          ),
          SizedBox(height: 30),
          actionButtons(context),
          SizedBox(height: 30),
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
                  'categoryPickerBloc': _categoryPickerBloc
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
          onPressed: () {
            // _save(context);
          },
          child: Text('Save'),
        ),
        RaisedButton(
          color: DefaultRedColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
