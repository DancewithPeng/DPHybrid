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
    
    weak var webPage: HybridWebViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let script = HybridConvenientCallScript(featureName: "takePhoto", convenientCallIdentifier: "native.ios.")
        print(script.source)
    }
    
    @objc
    func excuteScriptButtonDidTap(_ sender: Any?) {
        webPage?.webView.evaluateJavaScript("my_action();", completionHandler: { (result, error) in
            if let err = error {
                print(err)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webPage = segue.destination as? HybridWebViewController {
            webPage.defaultURL = Bundle.main.url(forResource: "demo", withExtension: "html")
            self.webPage = webPage
            webPage.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Excute", style: .plain, target: self, action: #selector(excuteScriptButtonDidTap(_:)))
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}

