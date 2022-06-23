import 'package:flutter/material.dart';
import 'package:ungegat/utility/my_constant.dart';
import 'package:ungegat/widgets/show_buttom.dart';
import 'package:ungegat/widgets/show_image.dart';
import 'package:ungegat/widgets/show_texe_buttom.dart';
import 'package:ungegat/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog({
    required String title,
    required String subTitle,
    String? label,
    Function()? pressFunc,
    String? label2,
    Function()? pressFunc2,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: SizedBox(
            width: 80,
            child: ShowImage(),
          ),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: subTitle),
        ),
        actions: [
          pressFunc == null
              ? ShowTexeButtom(
                  label: 'Ok',
                  pressFunc: () {
                    Navigator.pop(context);
                  })
              : ShowTexeButtom(label: label!, pressFunc: pressFunc),
          pressFunc2 == null
              ? const SizedBox()
              : ShowTexeButtom(label: label2!, pressFunc: pressFunc2),
        ],
      ),
    );
  }
}
