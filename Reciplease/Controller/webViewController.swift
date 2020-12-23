//
//  webViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 22/11/2020.
//

import UIKit
import WebKit

class WebViewController:  UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    var recipeURL: String?

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let depackedRecipeURL = recipeURL else { return }

        let originURL = URL(string: depackedRecipeURL)!
        let myRequest = URLRequest(url: originURL)
        DispatchQueue.main.async {
            self.webView.load(myRequest)
        }
    }

    internal func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.stopLoading()
    }

    override func viewWillDisappear(_ animated: Bool) {

        webView.stopLoading()
        webView.navigationDelegate = nil
    }

    deinit {
        view = UIView()
        webView = nil
    }
}
