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
    var spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        setupWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //If there is a url
        if websiteUrl != nil {
            
            let url = URL(string: websiteUrl!)
            
            guard url != nil else {
                print("Could not create URL object")
                return
            }
            
            //Create request object
            let request = URLRequest(url: url!)
            
            spinner.alpha = 1
            spinner.startAnimating()
            
            //Load to webView
            webView.load(request)
            
        }
        
    }
    
    func setupWebView(){
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    

}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        spinner.stopAnimating()
        spinner.alpha = 0
        
    }
    
}
