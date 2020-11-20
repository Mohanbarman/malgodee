import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/single_image_pick_bloc.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/image_preview.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/pick_image_button.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/save_category_brand.dart';
import 'package:ShoppingApp/models/brand.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/title_description_form.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/multiselect_field.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/multiselect_values.dart';

enum TypeOf { brand, category }

class BrandCategoryCrud extends StatelessWidget {
  SingleImagePickBloc _singleImagePickBloc = SingleImagePickBloc();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  MultiSelectValuesStream _multiSelectValuesStream = MultiSelectValuesStream();
  TypeOf typeOf;

  BrandModel model;

  BrandCategoryCrud({model, TypeOf typeOf}) {
    if (model != null) {
      this.model = model;
      this._titleController = TextEditingController(text: model.name);
      this._descriptionController = TextEditingController(
        text: model.description,
      );

      _singleImagePickBloc.add(model.image);
    }

    this.typeOf = typeOf;
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
          Title(typeOf == TypeOf.brand ? 'Add brand' : 'Add category'),
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
            name: typeOf == TypeOf.brand ? 'Brand' : 'Category',
            titleController: _titleController,
            descriptionController: _descriptionController,
          ),
          SizedBox(height: 30),
          model == null ? correspondingCategorySelector() : SizedBox(),
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

  Widget correspondingCategorySelector() {
    return StreamBuilder(
      stream: FirebaseStorageApi.streamOfCollection(
        collection: typeOf == TypeOf.brand ? 'categories' : 'brands',
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox();
        return CrudMultiselectField(
          multiSelectValuesStream: _multiSelectValuesStream,
          data: snapshot.data.docs
              .map((e) => {'display': e['name'], 'value': e.id})
              .toList(),
          title:
              'Please select a corresponding ${typeOf == TypeOf.brand ? 'categories' : 'brands'}',
        );
      },
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
          onPressed: model == null
              ? () {
                  saveCategoryOrBrand(
                    collection:
                        typeOf == TypeOf.category ? 'categories' : 'brands',
                    context: context,
                    correspondingCollection: 'brands',
                    correspondingFieldElements: _multiSelectValuesStream.values,
                    map: BrandModel(
                      categories: _multiSelectValuesStream.values,
                      description: _descriptionController.value.text,
                      name: _titleController.value.text,
                      image: _singleImagePickBloc.currPath,
                    ).toJson(),
                  );
                }
              : () {
                  print('it called');
                },
          child: model == null ? Text('Save') : Text('Update'),
        ),
        RaisedButton(
          color: DefaultRedColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () => Navigator.pop(context),
          child: model == null
              ? Text('Cancel', style: TextStyle(color: Colors.white))
              : Text('Delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
