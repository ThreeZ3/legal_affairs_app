/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-14
///
/// 小按钮

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

const Color _kDisabledBackground = Color(0xFFA9A9A9);
const Color _kDisabledForeground = Color(0xFFD1D1D1);
const double kMinInteractiveDimensionMagic = 44.0;

const EdgeInsets _kButtonPadding = EdgeInsets.all(16.0);
const EdgeInsets _kBackgroundButtonPadding =
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 64.0);

class SmallButton extends StatefulWidget {
  const SmallButton({
    Key key,
    @required this.child,
    this.padding,
    this.margin,
    this.color = const Color(0xffE1B96B),
    this.disabledColor,
    this.minWidth = kMinInteractiveDimensionMagic,
    this.minHeight = kMinInteractiveDimensionMagic,
    this.pressedOpacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.isShadow = false,
    this.shadowColor = 0xff2B2B57,
    this.border,
    @required this.onPressed,
  })  : assert(pressedOpacity == null ||
            (pressedOpacity >= 0.0 && pressedOpacity <= 1.0)),
        _filled = false,
        super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final Color disabledColor;
  final VoidCallback onPressed;
  final double minWidth;
  final double minHeight;
  final double pressedOpacity;
  final BorderRadius borderRadius;
  final bool _filled;
  final bool isShadow;
  final int shadowColor;
  final BoxBorder border;

  bool get enabled => onPressed != null;

  @override
  _SmallButtonState createState() => _SmallButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'));
  }
}

class _SmallButtonState extends State<SmallButton>
    with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 10);
  static const Duration kFadeInDuration = Duration(milliseconds: 100);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  AnimationController _animationController;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(SmallButton old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = widget.pressedOpacity ?? 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController = null;
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) return;
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0, duration: kFadeOutDuration)
        : _animationController.animateTo(0.0, duration: kFadeInDuration);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.enabled;
    final Color primaryColor = CupertinoTheme.of(context).primaryColor;
    final Color backgroundColor =
        widget.color ?? (widget._filled ? primaryColor : null);
    final Color foregroundColor = backgroundColor != null
        ? CupertinoTheme.of(context).primaryContrastingColor
        : enabled ? primaryColor : _kDisabledForeground;
    final TextStyle textStyle = CupertinoTheme.of(context)
        .textTheme
        .textStyle
        .copyWith(color: foregroundColor);

    return new Container(
      margin: widget.margin,
      decoration: BoxDecoration(borderRadius: widget.borderRadius),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: enabled ? _handleTapDown : null,
        onTapUp: enabled ? _handleTapUp : null,
        onTapCancel: enabled ? _handleTapCancel : null,
        onTap: widget.onPressed,
        child: Semantics(
          button: true,
          child: ConstrainedBox(
            constraints: widget.minWidth == null || widget.minHeight == null
                ? const BoxConstraints()
                : BoxConstraints(
                    minWidth: widget.minWidth, minHeight: widget.minHeight),
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  color: backgroundColor != null && !enabled
                      ? widget.disabledColor ?? _kDisabledBackground
                      : backgroundColor,
                  boxShadow: widget.isShadow
                      ? [
                          BoxShadow(
                              color: Color(widget.shadowColor).withOpacity(0.5),
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              spreadRadius: 0.5),
                        ]
                      : [],
                  border: widget.border,
                ),
                child: Padding(
                  padding: widget.padding ??
                      (backgroundColor != null
                          ? _kBackgroundButtonPadding
                          : _kButtonPadding),
                  child: Center(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: DefaultTextStyle(
                      style: textStyle,
                      child: IconTheme(
                        data: IconThemeData(color: foregroundColor),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
