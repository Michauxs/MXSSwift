//
//  MXSWebBrowseVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 24/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit
import WebKit

class MXSWebBrowseVC: MXSBaseVC, WKNavigationDelegate, WKUIDelegate {

	var webView : WKWebView?
	var urlStr : String?
	
	override func receiveArgsBePost(args: Any) {
		urlStr = args as? String
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bindingNavBar()
		
//		webView = WKWebView.init()
//		view.addSubview(webView!)
//		webView?.snp.makeConstraints({ (make) in
//			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
//		})
//		webView?.delegate = self
//		webView?.loadRequest(URLRequest.init(url: URL.init(string: urlStr!)!))
		
		
		let configuration = WKWebViewConfiguration.init()
		webView = WKWebView.init(frame: CGRect.zero, configuration: configuration)
		view.addSubview(webView!)
		webView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})
		webView?.load(URLRequest(url:  URL.init(string: urlStr!)!))
		webView?.navigationDelegate = self
		webView?.uiDelegate = self
		
//		var config = WkwebViewConfig()
//		config.isShowScrollIndicator = false
//		config.isProgressHidden = false
		
    }

	// MARK: - Layout
	override func NavBarLayout() {
		super.NavBarLayout()
		
	}
	
    // MARK: - Web Delegate
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		loadingView.start()
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		
		loadingView.stop()
		webView.evaluateJavaScript("document.title") { (data, error) in
			self.NavBar?.titleLabel?.text = data as? String
		}
		
//		let title = webView.stringByEvaluatingJavaScript(from: "document.title")
//		NavBar?.titleLabel?.text = title
	}
	
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		
	}
	
}
	
