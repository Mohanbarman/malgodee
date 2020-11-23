import 'package:ShoppingApp/screens/product_crud/local_utils/category_picker_bloc.dart';
import 'package:ShoppingApp/screens/product_crud/local_utils/dropdown_brand_bloc.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/not_found_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';

class CategoryAndBrandSelector extends StatelessWidget {
  DropdownBrandBloc dropdownBrandBloc;
  CategoryPickerBloc categoryPickerBloc;

  CategoryAndBrandSelector({this.dropdownBrandBloc, this.categoryPickerBloc});

  @override
  Widget build(BuildContext context) {
    print('*' * 20);
    print(categoryPickerBloc.categoriesPicked);
    print('*' * 20);
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButton: saveButton(context),
      body: Container(
        child: Column(
          children: [
            Container(height: ScreenPadding),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenPadding),
                  child: Text(
                    'Select brand : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                selectBrandDropdownButton(),
              ],
            ),
            Container(
              height: 2,
              color: Colors.black12,
              margin: EdgeInsets.all(ScreenPadding),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenPadding),
                  child: Text(
                    'Select categories',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Container(height: ScreenPadding),
            Expanded(child: selectCategoryListView()),
          ],
        ),
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.check),
    );
  }

  Widget selectCategoryListView() {
    return Container(
      child: StreamBuilder(
        stream: dropdownBrandBloc.stream,
        builder: (context, dropdownBrandSnapshot) {
          if (dropdownBrandBloc.currValue == null)
            return NotFoundPlaceholder(label: 'Please select a brand first');

          return StreamBuilder(
            stream: categoryPickerBloc.stream,
            builder: (context, categoryPickerSnapshot) {
              return StreamBuilder(
                stream: FirebaseStorageApi.streamOfCollectionFiltered(
                  collection: 'categories',
                  field: 'brands',
                  containsValue: dropdownBrandBloc.currValue,
                ),
                builder: (context, categoriesSnapshot) {
                  if (!categoriesSnapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: categoriesSnapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenPadding,
                        ),
                        title: Text(
                          categoriesSnapshot.data.docs[index]['name'],
                        ),
                        value: categoryPickerBloc.categoriesPicked.contains(
                          categoriesSnapshot.data.docs[index].id,
                        ),
                        onChanged: (value) {
                          if (value)
                            categoryPickerBloc.add(
                              categoriesSnapshot.data.docs[index].id,
                            );
                          if (!value)
                            categoryPickerBloc.remove(
                              categoriesSnapshot.data.docs[index].id,
                            );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget selectBrandDropdownButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          child: RaisedButton(
            onPressed: () {},
            child: Container(
              child: StreamBuilder(
                stream: FirebaseStorageApi.streamOfCollection(
                  collection: 'brands',
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );

                  return DropdownButtonHideUnderline(
                    child: StreamBuilder(
                      stream: dropdownBrandBloc.stream,
                      builder: (context, dropdownSnapshot) {
                        print(dropdownBrandBloc.currValue);

                        return Container(
                          width: 200,
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            value: dropdownBrandBloc.currValue,
                            onChanged: (value) {
                              print(value);
                              dropdownBrandBloc.add(value);
                            },
                            items: snapshot.data.docs
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    child: Text(e['name']),
                                    value: e.id,
                                  ),
                                )
                                .toList()
                                .cast<DropdownMenuItem<String>>(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
