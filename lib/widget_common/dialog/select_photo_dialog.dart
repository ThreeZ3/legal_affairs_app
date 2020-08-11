import 'package:flutter/material.dart';

void selectPhotoDialog(
  context, {
  Function takePhoto,
  Function openGallery,
}) async {
  var result = await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: ['0', '拍照', '相册'].map((item) {
            return item == '0'
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      '选择图片',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        print(item);
                        if (item == '拍照') {
                          Navigator.pop(context);
                          takePhoto();
                        } else if (item == '相册') {
                          Navigator.pop(context);
                          openGallery();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          item,
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
          }).toList(),
        ),
      );
    },
  );
  return result;
}
