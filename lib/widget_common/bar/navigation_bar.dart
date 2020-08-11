import 'package:flutter/cupertino.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-12
///
/// AppBar封装
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const NavigationBar({
    this.title = '',
    this.showBackIcon = true,
    this.rightDMActions,
    this.backgroundColor = const Color(0xff333333),
    this.mainColor = Colors.white,
    this.titleW,
    this.bottom,
    this.leading,
    this.isCenterTitle = true,
    this.iconColor = const Color(0xffdcba76),
    this.brightness = Brightness.dark,
    this.automaticallyImplyLeading = true,
    this.icons = Icons.arrow_back_ios,
  });

  final String title;
  final bool showBackIcon;
  final List<Widget> rightDMActions;
  final Color backgroundColor;
  final Color mainColor;
  final Widget titleW;
  final PreferredSizeWidget bottom;
  final Widget leading;
  final bool isCenterTitle;
  final Color iconColor;
  final Brightness brightness;
  final bool automaticallyImplyLeading;
  final IconData icons;

  @override
  Size get preferredSize => new Size(100, bottom != null ? 100 : 48);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      title: titleW == null
          ? new Text(
              title,
              style: new TextStyle(color: mainColor),
            )
          : titleW,
      backgroundColor: backgroundColor,
      elevation: 0.0,
      brightness: brightness,
      leading: leading == null
          ? showBackIcon
              ? Navigator.canPop(context)
                  ? new InkWell(
                      child: new Container(
                        width: 24,
                        padding: EdgeInsets.all(13),
                        child: Image.asset(
                          'assets/register/register_back.png',
                          color: iconColor,
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.maybePop(context);
                      },
                    )
                  : null
              : null
          : leading,
      centerTitle: isCenterTitle,
      bottom: bottom != null ? bottom : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: rightDMActions ?? [new Center()],
    );
  }
}
