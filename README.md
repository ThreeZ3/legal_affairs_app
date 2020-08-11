# jh_legal_affairs

 I am involved in the project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 富文本插入图片被删除文字

> /Users/q1/.pub-cache/hosted/pub.flutter-io.cn/zefyr-0.10.0/lib/src/widgets/controller.dart

```dart
Delta user = Delta()
          ..retain(index)
          ..insert(text);
//          ..delete(length)  //这个要注释
```

> 关于视频播放：
      android:usesCleartextTraffic="true"

已注释
> /Users/q1/.pub-cache/hosted/pub.flutter-io.cn/notus-0.1.5/lib/src/heuristics/format_rules.dart

# 支付宝插件IOS错误

在podFile加：
```dart
pre_install do |installer|
  # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
  Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end
```

# 支付宝IOS错误2
在插件的ios目录中flutter_alipay.podspec，加入
```
s.static_framework = true
```