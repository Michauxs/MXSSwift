//
//  MXSShowDiaryVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSShowDiaryVC: MXSBaseVC, UITextViewDelegate {

	var dateLabel : UILabel?
	var weatherLabel : UILabel?
	var contentTextView : UITextView?
	var thinkTextView : UITextView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bindingNavBar()
		setupUI()
		
    }
	
	func setupUI() {
		let dateTitle = UILabel.init(text: "Date", fontSize: 13, textColor: UIColor.black, alignment: .left)
		view.addSubview(dateTitle)
		dateTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(view).offset(S_N_BAR_H+44)
		})
		
		dateLabel = UILabel.init(text: "Date", fontSize: 13, textColor: UIColor.black, alignment: .left)
		view.addSubview(dateLabel!)
		dateLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15+60)
			make.centerY.equalTo(dateTitle)
		})
		
		let weatherTitle = UILabel.init(text: "Weather", fontSize: 13, textColor: UIColor.black, alignment: .left)
		view.addSubview(weatherTitle)
		weatherTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(dateTitle.snp.bottom).offset(44)
		})
		
		weatherLabel = UILabel.init(text: "Sunny", fontSize: 13, textColor: UIColor.black, alignment: .left)
		view.addSubview(weatherLabel!)
		weatherLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.centerY.equalTo(weatherTitle)
		})
		
		let contentTitle = UILabel.init(text: "Content", fontSize: 13, textColor: UIColor.black, alignment: .left)
		view.addSubview(contentTitle)
		contentTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(weatherTitle.snp.bottom).offset(44)
		})
		
		contentTextView = UITextView.init()
		contentTextView?.text = "content"
		view.addSubview(contentTextView!)
		contentTextView?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.top.equalTo(contentTitle)
			make.right.equalTo(view).offset(-15)
			make.height.equalTo(30)
		})
		
		let thinkTitle = UILabel.init(text: "Think", fontSize: 13, textColor: UIColor.black, alignment: .left)
		view.addSubview(thinkTitle)
		thinkTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(contentTextView!.snp.bottom).offset(44)
		})
		
		thinkTextView = UITextView.init()
		thinkTextView?.text = "think"
		view.addSubview(thinkTextView!)
		thinkTextView?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.top.equalTo(thinkTitle)
			make.right.equalTo(view).offset(-15)
			make.height.equalTo(30)
		})
		
		contentTextView?.isEditable = true
		contentTextView?.isScrollEnabled = false
		
		thinkTextView?.isEditable = true
		thinkTextView?.isScrollEnabled = false
//		thinkTextView.
		
		contentTextView?.delegate = self
		thinkTextView?.delegate = self
		
	}
	
	func textViewDidChange(_ textView: UITextView) {
		
	}
	
	func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
		return true
	}
	
}
