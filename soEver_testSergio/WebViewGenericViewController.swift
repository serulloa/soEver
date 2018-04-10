//
//  WebViewGenericViewController.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 9/4/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import WebKit

class WebViewGenericViewController: UIViewController {
    
    //MARK: - Properties
    var myUrl : String?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    //MARK: - IBActions
    @IBAction func closeVCACTION(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let myUrlString = myUrl else { return }
        let urlData = URL(string: myUrlString)!
        let urlRequest = URLRequest(url: urlData)
        myWebView.load(urlRequest)
        
        myWebView.navigationDelegate = self
        myActivityIndicator.isHidden = true
        
        self.title = myUrlString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - Extensions
extension WebViewGenericViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.isHidden = true
        myActivityIndicator.stopAnimating()
    }
    
}
