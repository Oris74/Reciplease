//
//  webViewController.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 22/11/2020.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    var recipeURL: String?
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let depackedRecipeURL = recipeURL else { return }

        let originURL = URL(string: depackedRecipeURL)!
        let myRequest = URLRequest(url: originURL)
        DispatchQueue.main.async {        self.webView.load(myRequest)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        webView.stopLoading()
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "...")
        webView.uiDelegate = nil
    }
    deinit {
       view = UIView()
       webView = nil
    }
}
