//
//  MXSProgressHUD.swift
//  MXSSwift
//
//  Created by Alfred Yang on 25/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSProgressHUD: UIView {

	var activityView : UIActivityIndicatorView?
	var loadingBg : UIView?
	var timer : Timer?
	
	var count : Int = 0
	var secondCount : Int = 0
	
	convenience init(_ supview: UIView) {
		self.init()
		supview.addSubview(self)
		self.backgroundColor = UIColor.clear
		self.snp.makeConstraints { (make) in
			make.edges.equalTo(supview)
		}
		
		loadingBg = UIView.init()
		loadingBg?.setRadius(radius: 6, borderColor: MXSNothing.shared, borderWidth: 0, backgropund: UIColor.alphaBlack as Any)
		addSubview(loadingBg!)
		loadingBg?.snp.makeConstraints { (make) in
			make.center.equalTo(self)
			make.size.equalTo(CGSize.init(width: 80, height: 80))
		}
		
		activityView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
//		activityView.
		addSubview(activityView!)
		activityView?.snp.makeConstraints({ (make) in
			make.center.equalTo(self)
			make.size.equalTo(CGSize.init(width: 40, height: 40))
		})
		
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
		
	}
	
	@objc func timerRun () {
		secondCount = secondCount-1
		if secondCount == 0 {
			hiddenWithTime()
		}
	}
	
	func start () {
		if  count == 0 {
			self.isHidden = false
			activityView?.startAnimating()
			timer?.fireDate = Date.distantPast
		}
		
		secondCount = 30
		count = count+1
	}
	
	func stop () {
		count = count-1
		
		if count == 0 {
			self.isHidden = true
			activityView?.stopAnimating()
			timer?.fireDate = Date.distantFuture
		}
	}
	
	func hiddenWithTime () {
		self.isHidden = true
		activityView?.stopAnimating()
		timer?.fireDate = Date.distantFuture
		secondCount = 0
		count = 0
	}
	
	func invalidate() {
		timer?.invalidate()
		timer = nil
	}
}
