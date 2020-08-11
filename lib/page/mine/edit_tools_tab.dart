import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/common/ui.dart';

class EditToolsTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      height: MediaQuery.of(context).size.height / 19,
      child: Row(
        children: <Widget>[
          SizedBox(width: 16),
          CachedNetworkImage(
            imageUrl:
            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd38e43a07-9c4d-48f2-a24f-9a74c400351b",
            width: 18,
            height: 15,
            color: Colors.black,
          ),
          Space(),
          VerticalLine(
            color: Colors.grey[400],
          ),
          Space(),
          CachedNetworkImage(
            imageUrl:
            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd96a641e2-db4d-4897-b87e-de467d10cc3e",
            width: 18,
            height: 15,
            color: Colors.black,
          ),
          Space(),
          VerticalLine(
            color: Colors.grey[400],
          ),
          Space(),
          CachedNetworkImage(
            imageUrl:
            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd79c6bbac-318a-42c5-8642-bd1d3a1b46be",
            width: 18,
            height: 15,
            color: Colors.black,
          ),
          Space(),
          VerticalLine(
            color: Colors.grey[400],
          ),
          Space(),
          CachedNetworkImage(
            imageUrl:
            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd25a02535-c281-4da1-a414-baf5e10b7873",
            width: 18,
            height: 15,
            color: Colors.black,
          ),
          Space(),
          VerticalLine(
            color: Colors.grey[400],
          ),
          Space(),
          CachedNetworkImage(
            imageUrl:
            "https://lanhu.oss-cn-beijing.aliyuncs.com/xd45362611-b6ca-4863-b151-98ffec854786",
            width: 18,
            height: 15,
            color: Colors.black,
          ),
          Space(),
        ],
      ),
    );
  }
}