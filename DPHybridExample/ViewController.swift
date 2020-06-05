//
//  ViewController.swift
//  DPHybridExample
//
//  Created by DP on 2019/11/4.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPHybrid

class ViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.addFeature(withName: "takePhoto") { (message) in
            // 原生处理拍照逻辑
            print("拍照片啦：\(message.body)")
        }
        configuration.add(WKUserScript(source: "function hello() { alert('Hello World'!); }"))
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
        
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
        webView.load(request)
    }
    
    @IBAction func triggleButtonDidTap(_ sender: Any) {
//        let paras = ["name": "asdfs", "age": 18];
        webView.evaluateJavaScript("takePhoto('hello', 'world');") { (result, error) in
            guard let ret = result else {
                if let err = error {
                    print(err)
                } else {
                    print("empty result")
                }
                return
            }
            
            print(ret)
        }
    }
}

