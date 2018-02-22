//
//  MXSWebBrowseVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 24/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit
import WebKit

class MXSWebBrowseVC: MXSBaseVC, WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate {

	var webView : WKWebView?
	var urlStr : String?
	var progressView : UIView?
	var scrollOffSetY : CGFloat = 0
	
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
		webView?.allowsBackForwardNavigationGestures = true
		if #available(iOS 9.0, *) {
			webView?.allowsLinkPreview = true
		} else {
			// Fallback on earlier versions
		}
		
		webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
		webView?.scrollView.delegate = self
		
		let sign = UILabel.init(text: "Michauxs", fontSize: 13, textColor: .random, alignment: .center)
		webView!.addSubview(sign)
		sign.snp.makeConstraints { (make) in
			make.top.equalTo(webView!).offset(10)
			make.centerX.equalTo(webView!)
		}
		webView?.sendSubview(toBack: sign)
		
		progressView = UIView()
		progressView?.backgroundColor = .theme
		NavBar!.addSubview(progressView!)
		progressView?.snp.makeConstraints({ (make) in
			make.bottom.equalTo(NavBar!)
			make.left.equalTo(NavBar!)
			make.height.equalTo(1)
			make.width.equalTo(0)
		})
    }

	// MARK: - Layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.rightBtn?.setTitle("Close", for: .normal)
	}
	
	override func didNavBarLeftClick() {
		if (webView?.canGoBack)! {
			webView?.goBack()
		} else {
			super.didNavBarLeftClick()
			webView?.removeObserver(self, forKeyPath: "estimatedProgress")
		}
	}
	
	override func didNavBarRightClick() {
		super.didNavBarLeftClick()
		
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView?.isHidden = webView!.estimatedProgress == 1
			progressView!.snp.updateConstraints({ (make) in
				make.width.equalTo(SCREEN_HEIGHT * CGFloat(webView!.estimatedProgress))
			})
		}
	}
	
    // MARK: - Web Delegate
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//		loadingView.start()
		progressView?.isHidden = false
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		progressView?.isHidden = true
//		loadingView.stop()
		webView.evaluateJavaScript("document.title") { (data, error) in
			self.NavBar?.titleLabel?.text = data as? String
		}
		
//		let title = webView.stringByEvaluatingJavaScript(from: "document.title")
//		NavBar?.titleLabel?.text = title
	}
	
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		
	}
	
	//MARK: - scorll
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset_y = scrollView.contentOffset.y
		if scrollOffSetY - offset_y < 0 {
			MXSLog("Page to Up")
			
		} else {
			MXSLog("Page to Down")
			
			if scrollOffSetY < -44 {
				webView?.reload()
				scrollView.contentOffset = CGPoint.zero
			}
		}
		
		scrollOffSetY = offset_y
	}
	
}
	

