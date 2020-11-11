//
//  ViewController.swift
//  DPHybridExample
//
//  Created by DP on 2019/11/4.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPHybrid

class ViewController: UIViewController, WKScriptMessageHandler {
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
//        configuration.userContentController.addUserScript(WKUserScript(source: "", injectionTime: .atDocumentStart, forMainFrameOnly: true))
//        configuration.addFeature(withName: "takePhoto") { (message) in
//            // 原生处理拍照逻辑
//            print("拍照片啦：\(message.body)")
//        }
//        configuration.add(WKUserScript(source: "function hello() { alert('Hello World'!); }"))
//        configuration.addFeature(withName: "hello") { (message) in
//            print("------ \(message.body)")
//        }
//        configuration.userContentController.add(self, name: "hello");
//        configuration.addFeature(withName: "myHello") { (message) in
//            print("阿啦啦啦\(message.body)")
//        }
        
        configuration.userContentController.add(self, name: "myJSFunc")
        configuration.addFeature("myHello", convenientCallIdentifier: "myJS.myCall.test.demo") { (message) in
            print("阿啦啦啦\(message.body)")
        }
        
        let wbv = WKWebView(frame: view.bounds, configuration: configuration)
        return wbv;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
//        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
//        webView.load(request)
        guard let url = Bundle.main.url(forResource: "demo", withExtension: "html") else {
            return
        }
        
        if let html = try? String(contentsOf: url) {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    @IBAction func triggleButtonDidTap(_ sender: Any) {
//        let paras = ["name": "asdfs", "age": 18];
//        webView.evaluateJavaScript("takePhoto('hello', 'world');") { (result, error) in
//            guard let ret = result else {
//                if let err = error {
//                    print(err)
//                } else {
//                    print("empty result")
//                }
//                return
//            }
//
//            print(ret)
//        }
        webView.evaluateJavaScript("myJS.myCall.test.demo.myHello(1, 2, 3);") { (result, error) in
            
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        print(message.name)
        print(message.frameInfo)
        
        if let args = message.body as? [Any] {
            print(args)
        }
    }
}
