# 混合开发框架

[TOC]

## 功能列表

- 向WebView添加原生能力
- 向WebView注入JS代码



## 安装
- CocoaPods
```podfile
pod 'DPHybrid', '~> 1.1.1'
```



## 使用

### 添加原生能力

```swift
let configuration = WKWebViewConfiguration()
configuration.addFeature(withName: "takePhoto") { (message) in
		// 原生处理拍照逻辑...
}
let webView = WKWebView(frame: ..., configuration: configuration)
```

### 注入JS代码

```swift
let configuration = WKWebViewConfiguration()
configuration.add(WKUserScript(source: "function hello() { alert('Hello World!'); }"))
let webView = WKWebView(frame: ..., configuration: configuration)
```



## LICENSE

MIT License



Copyright (c) 2020 DP



Permissionis hereby granted, free of charge, to any person obtaining a copy

of this software and associated documentation files (the "Software"), to deal

in the Software without restriction, including without limitation the rights

to use, copy, modify, merge, publish, distribute, sublicense, and/or sell

copies of the Software, and to permit persons to whom the Software is

furnished to do so, subject to the following conditions:



The above copyright notice and this permission notice shall be included in all

copies or substantial portions of the Software.



THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR

IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,

FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE

AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER

LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,

OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

SOFTWARE.
