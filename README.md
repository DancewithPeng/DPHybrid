# 混合开发框架

[TOC]

## 功能列表

- 向WebView添加原生能力
- 向WebView注入JS代码



## 安装
- CocoaPods
```podfile
pod 'DPHybrid', '~> 1.0.0'
```



## 使用

首先需要用`HybridBuilder`添加js调用的能力
```swift
HybridBuilder.shared.addFeature("hello") { (message) in
    print("Hello!!!")
}
```
对应的js调用方式为
```js
native.hello();
```

然后在用`HybridWebView`或`WKWebView`来展示网页即可



### HybridWebView

```swift
let webView = HybridWebView()
webView.loadRequest(...)
```



### WKWebView

```swift
let webView = WKWebView(frame: .zero, configuration: HybridBuilder.shared.configuration)
webView.loadRequest(...)
```# DPHybrid
