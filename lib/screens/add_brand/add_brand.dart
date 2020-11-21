import 'package:ShoppingApp/models/brand.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/multiselect_values.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/single_image_pick_bloc.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/image_preview.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/pick_image_button.dart';
import 'package:ShoppingApp/widgets/crud_form/utils/save_category_brand.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/title_description_form.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/crud_form/widgets/multiselect_field.dart';

class AddBrand extends StatelessWidget {
  SingleImagePickBloc _singleImagePickBloc = SingleImagePickBloc();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  MultiSelectValuesStream _multiSelectValuesStream = MultiSelectValuesStream();

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
          Title('Add brand'),
          SizedBox(height: 30),
          Container(
            child: ImagePreview(
              bloc: _singleImagePickBloc,
              previewShape: PreviewShape.circle,
            ),
          ),
          SizedBox(height: 30),
          PickImageButton(bloc: _singleImagePickBloc),
          SizedBox(height: 60),
          TitleDescriptionForm(
            name: 'Brand',
            titleController: _titleController,
            descriptionController: _descriptionController,
          ),
          SizedBox(height: 30),
          correspondingBrandsSelector(),
          SizedBox(height: 30),
          actionButtons(context),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget correspondingBrandsSelector() {
    return StreamBuilder(
      stream: FirebaseStorageApi.streamOfCollection(collection: 'categories'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox();
        return CrudMultiselectField(
          multiSelectValuesStream: _multiSelectValuesStream,
          data: snapshot.data.docs
              .map((e) => {'display': e['name'], 'value': e.id})
              .toList(),
          title: 'Select corresponding categories',
          validationMsg: 'Please select corresponding categories',
        );
      },
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
            saveCategoryOrBrand(
              collection: 'brands',
              context: context,
              correspondingCollection: 'categories',
              correspondingFieldElements: _multiSelectValuesStream.values,
              map: BrandModel(
                name: _titleController.value.text,
                description: _descriptionController.value.text,
                categories: _multiSelectValuesStream.values,
                image: _singleImagePickBloc.currPath,
              ).toJson(),
            );
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
