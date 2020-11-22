import 'package:ShoppingApp/models/category.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/delete_category_brand.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/single_image_pick_bloc.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/image_preview.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/pick_image_button.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/update_document.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/title_description_form.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';

class EditCategory extends StatelessWidget {
  SingleImagePickBloc _singleImagePickBloc = SingleImagePickBloc();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  CategoryModel model;

  EditCategory({categoryModel}) {
    this.model = categoryModel;
    this._titleController = TextEditingController(text: model.name);
    this._descriptionController = TextEditingController(
      text: model.description,
    );

    _singleImagePickBloc.add(model.image);
  }

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
          Title('Edit category'),
          SizedBox(height: 30),
          Container(
            child: Center(
              child: ImagePreview(
                bloc: _singleImagePickBloc,
                previewShape: PreviewShape.circle,
              ),
            ),
          ),
          SizedBox(height: 30),
          PickImageButton(bloc: _singleImagePickBloc),
          SizedBox(height: 60),
          TitleDescriptionForm(
            name: 'Category',
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

  Widget Title(String title) {
    return SizedBox(
      height: 50,
      child: Center(
        child: UnderlinedText(title).noUnderline(),
      ),
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
            _update(context);
          },
          child: Text('Update'),
        ),
        RaisedButton(
          color: DefaultRedColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () => _delete(context),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _delete(BuildContext context) {
    deleteCategoryOrBrand(
      context: context,
      collection: 'categories',
      id: model.id,
      correspondingCollection: 'brands',
      correspondingFieldElements: model.brands,
    );
  }

  void _update(BuildContext context) async {
    String image = _singleImagePickBloc.currPath;
    String name = _titleController.value.text;
    String description = _descriptionController.value.text;
    String id = model.id;

    updateDoc(
      map: CategoryModel(
        id: id,
        description: description,
        name: name,
        image: image,
      ).toJson(),
      collection: 'categories',
      context: context,
    );
  }
}
