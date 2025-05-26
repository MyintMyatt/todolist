import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolists/models/AppData.dart';
import 'package:todolists/models/category.dart';
import 'package:todolists/services/db_service.dart';
import 'package:todolists/themes/theme.dart';
import 'package:todolists/widgets/drop_down.dart';

showDialogForCustom({
  required BuildContext context,
  required DBService dbService,
  required AppThemeData theme,
  required AnimationStyle animationSytle,
  required Function(String newCustomValue) newCustomValue,
  Function(String repeatType)? repeatType,
  required bool isRequiredIcon
}) {
  TextEditingController _controller = TextEditingController();
  String? selectedType;
  showDialog(
    context: context,
    builder: (builder) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(
           isRequiredIcon?  'New Custom Repeat' : 'New Category',
            style: theme.subTitleStyle,
          ),
          content: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: isRequiredIcon ? TextInputType.number : TextInputType.text,
                    decoration: InputDecoration(),
                  ),
                ),
                isRequiredIcon ? timeSmallWidgetDropdown(
                    items: AppData.newCustomRepeatDropDown,
                    onItemSelected: (value) {
                      setState((){
                        selectedType = value;
                      });
                    },
                    icon: Icons.category_rounded,
                    animationSytle: animationSytle,
                    width: 90,
                    textWidget: Text(
                      selectedType??'Type',
                      style: theme.smallTextStyle,
                    )): SizedBox()
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () async{
                  // if(_controller.text.isEmpty || )
                  if (_controller.text.isEmpty ||  (isRequiredIcon && selectedType == null)) {
                    Get.snackbar('Error', isRequiredIcon? 'Please enter a value and select a type' : 'Please enter a new category',backgroundColor: Colors.red);
                    return;
                  }
                  else{
                    newCustomValue(_controller.text);
                    if(isRequiredIcon){
                      repeatType!(selectedType!);
                    }
                    //logic to insert category to db
                    Navigator.pop(context);
                  }

                },

                child: Text('Submit')),
          ],
        );
      });
    },
  );
}
