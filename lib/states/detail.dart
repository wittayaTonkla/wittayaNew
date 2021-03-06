// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ungegat/models/job_model.dart';
import 'package:ungegat/utility/my_constant.dart';
import 'package:ungegat/utility/my_dialog.dart';
import 'package:ungegat/widgets/show_icon_button.dart';
import 'package:ungegat/widgets/show_image.dart';
import 'package:ungegat/widgets/show_text.dart';

class DeTail extends StatefulWidget {
  final JobModel jobModel;
  const DeTail({
    Key? key,
    required this.jobModel,
  }) : super(key: key);

  @override
  State<DeTail> createState() => _DeTailState();
}

class _DeTailState extends State<DeTail> {
  JobModel? jobModel;
  File? file;

  @override
  void initState() {
    super.initState();
    jobModel = widget.jobModel;
  }

  Future<void> processTakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      file = File(result.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          text: jobModel!.job,
          textStyle: MyConstant().h2Style(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: MyConstant.dark,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
        return Center(
          child: Column(
            children: [
              newImage(boxConstraints),
            ],
          ),
        );
      }),
    );
  }

  Container newImage(BoxConstraints boxConstraints) {
    return Container(
        margin: const EdgeInsets.only(top: 36, bottom: 16),
        width: boxConstraints.maxWidth * 0.6,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: file == null ? const ShowImage(
                path: 'images/image.png',
              )
              :Image.file(file!),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ShowIconButton(
                iconData: Icons.add_a_photo,
                pressFunc: () {
                  MyDialog(context: context).normalDialog(
                      label: 'Camera',
                      label2: 'Gallery',
                      pressFunc: () {
                        processTakePhoto(imageSource: ImageSource.camera);
                        Navigator.pop(context);
                      },
                      pressFunc2: () {
                        processTakePhoto(imageSource: ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      title: 'Source Image',
                      subTitle: 'Plase Tab Camera or Gallery');
                },
              ),
            )
          ],
        ));
  }
}
