//
//  WebViewController.swift
//  AroundTown
//
//  Created by Jocelyn Icaza on 1/8/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView = WKWebView()
    var websiteUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
    }
    

}

extension WebViewController: WKNavigationDelegate {
    
    
}
