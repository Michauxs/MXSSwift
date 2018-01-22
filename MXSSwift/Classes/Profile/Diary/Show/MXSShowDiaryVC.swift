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
	
	var pickerView : MXSPickerView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bindingNavBar()
		setupUI()
		
    }
	
	func setupUI() {
		let dateTitle = UILabel.init(text: "Date", fontSize: 13, textColor: UIColor.dullWhite, alignment: .left)
		view.addSubview(dateTitle)
		dateTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(view).offset(S_N_BAR_H+44)
		})
		
		dateLabel = UILabel.init(text: "Date", fontSize: 13, textColor: UIColor.gray, alignment: .left)
		view.addSubview(dateLabel!)
		dateLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15 + 60)
			make.centerY.equalTo(dateTitle)
		})
		
		let todayBtn = UIButton.init(text: "Today", fontSize: 13, textColor: UIColor.theme, background: MXSNothing.shared)
		todayBtn.setRadius(radius: 4, borderColor: UIColor.theme, borderWidth: 0.5, backgropund: MXSNothing.shared)
		view.addSubview(todayBtn)
		todayBtn.snp.makeConstraints { (make) in
			make.right.equalTo(view).offset(-15)
			make.centerY.equalTo(dateTitle)
			make.size.equalTo(CGSize.init(width: 50, height: 30))
		}
		todayBtn.addTarget(self, action: #selector(signTodayBtnClick), for: .touchUpInside)
		
		let weatherTitle = UILabel.init(text: "Weather", fontSize: 13, textColor: UIColor.dullWhite, alignment: .left)
		view.addSubview(weatherTitle)
		weatherTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(dateTitle.snp.bottom).offset(44)
		})
		
		let addOptBtn = UIButton.init(text: "Setting", fontSize: 13, textColor: UIColor.theme, background: MXSNothing.shared)
		addOptBtn.setRadius(radius: 4, borderColor: UIColor.theme, borderWidth: 0.5, backgropund: MXSNothing.shared)
		view.addSubview(addOptBtn)
		addOptBtn.snp.makeConstraints { (make) in
			make.right.equalTo(view).offset(-15)
			make.centerY.equalTo(weatherTitle)
			make.size.equalTo(CGSize.init(width: 50, height: 30))
		}
		addOptBtn.addTarget(self, action: #selector(didWeatherTap), for: .touchUpInside)
		
		weatherLabel = UILabel.init(text: "weather", fontSize: 13, textColor: UIColor.gray, alignment: .left)
		view.addSubview(weatherLabel!)
		weatherLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.centerY.equalTo(weatherTitle)
			make.right.equalTo(addOptBtn.snp.left).offset(-15)
		})
//		weatherLabel?.isUserInteractionEnabled = true
//		weatherLabel?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didWeatherTap)))
		
		
//		let line = UIView.init()
//		line.backgroundColor = UIColor.grayline
//		view.addSubview(line)
//		line.snp.makeConstraints { (make) in
//			make.top.equalTo(weatherLabel!.snp.bottom).offset(8)
//			make.left.equalTo(weatherLabel!)
//			make.right.equalTo(view).offset(-15)
//			make.height.equalTo(0.5)
//		}
		
		let contentTitle = UILabel.init(text: "Content", fontSize: 13, textColor: UIColor.dullWhite, alignment: .left)
		view.addSubview(contentTitle)
		contentTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(weatherTitle.snp.bottom).offset(44)
		})
		
		contentTextView = UITextView.init()
		contentTextView?.text = ""
		view.addSubview(contentTextView!)
		contentTextView?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.top.equalTo(contentTitle)
			make.right.equalTo(view).offset(-15)
			make.height.greaterThanOrEqualTo(25)
		})
		
		let thinkTitle = UILabel.init(text: "Think", fontSize: 13, textColor: UIColor.dullWhite, alignment: .left)
		view.addSubview(thinkTitle)
		thinkTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(view).offset(15)
			make.top.equalTo(contentTextView!.snp.bottom).offset(44)
		})
		
		thinkTextView = UITextView.init()
		thinkTextView?.text = ""
		view.addSubview(thinkTextView!)
		thinkTextView?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.top.equalTo(thinkTitle)
			make.right.equalTo(view).offset(-15)
			make.height.greaterThanOrEqualTo(25)
		})
		
		contentTextView?.isEditable = true
		contentTextView?.isScrollEnabled = false
		
		thinkTextView?.isEditable = true
		thinkTextView?.isScrollEnabled = false
		
		contentTextView?.delegate = self
		thinkTextView?.delegate = self
		
		contentTextView?.textContainerInset = UIEdgeInsets.init(top: 2, left: 0, bottom: 2, right: 0)
		thinkTextView?.textContainerInset = UIEdgeInsets.init(top: 2, left: 0, bottom: 2, right: 0)
		
		contentTextView?.backgroundColor = UIColor.grayline
		thinkTextView?.backgroundColor = UIColor.grayline
		
		view.isUserInteractionEnabled = true
		view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapElse)))
		
		pickerView = MXSPickerView.init(vc: self)
		view.addSubview(pickerView!)
		pickerView?.registDelegate(MXSPickerDlg())
//		let weather_data = kMXSWeathers
		pickerView?.dlg?.loadData = kMXSWeathers
	}
	
	//MARK:layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.titleLabel?.text = "Diary Edit"
		NavBar?.rightBtn?.setTitle("Save", for: .normal)
	}
	
	//MARK:actions
	@objc func tapElse () {
		view.endEditing(true)
	}
	
	@objc func signTodayBtnClick () {
		let today = MXSToolsCmd.shared.dateConvertString(Date.init())
		dateLabel?.text = today
	}
	
	@objc func didWeatherTap() {
		pickerView?.showInSupView()
	}
	
	
	//MARK:notifies
	override func didNavBarRightClick() {
		
		if contentTextView?.text.count == 0 || thinkTextView?.text.count == 0 {
			alertView.titleLabel?.text = "Diary is not complete"
			alertView.showAlert()
			return
		}
		
		var dic = Dictionary<String, Any>.init()
		let wth = weatherLabel?.text
		if wth!.contains("转") {
			let arr = wth!.components(separatedBy: "转")
			let first = kMXSWeathers.index(of: arr.first!)
			let last = kMXSWeathers.index(of: arr.last!)
			
			dic["weather"] = (first!+10)*100 + last!+10
		} else {
			let index = kMXSWeathers.index(of: wth!)! + 10
			dic["weather"] = index
		}
		
		dic["date_daily"] = MXSToolsCmd.shared.stringConvertDate(dateLabel!.text!)
		dic["diary_content"] = contentTextView?.text
		dic["diary_think"] = thinkTextView?.text
		MXSDiary.addDiaryWithDictionary(dic)
		
		alertView.titleLabel?.text = "Diary has been saved"
		alertView.showAlert()
	}
	
	override func hideBtmAlertComplete(_ title: String) {
		
		if title == "Diary has been saved" {
			didNavBarLeftClick()
		}
	}
	
	override func pickerSave() {
		let row = pickerView?.picker?.selectedRow(inComponent: 0)
		let weather = kMXSWeathers[row!]
		
		if weatherLabel?.text == "weather" {
			weatherLabel?.text = weather
		} else {
			let yet = weatherLabel?.text
			weatherLabel?.text = yet! + "转" + weather
		}
	}
	
	//MARK:textview delegate
	func textViewDidChange(_ textView: UITextView) {

	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		
		return true
	}
	
}
