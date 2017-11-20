//
//  MXSNavBar.swift
//  MXSSwift
//
//  Created by Alfred Yang on 16/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSNavBar: UIView {
	
	var leftBtn : UIButton?
	var rightBtn : UIButton?
	var titleLabel : UILabel?
	var topBackground : UIView?
	weak var controller : MXSBaseVC?

	//init with controller
//	public func initWithVC (vc:MXSBaseVC) {
//
//		let screen_width = UIScreen.main.bounds.size.width
//		super.init(frame: CGRect.init(x: 0, y: 20, width: screen_width, height: 44))
//		setupSubviews()
//		controller = vc
//	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
	}
	
	convenience init(vc:MXSBaseVC) {
		let screen_width = UIScreen.main.bounds.size.width
		self.init(frame: CGRect.init(x: 0, y: 20, width: screen_width, height: 44))
		controller = vc
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupSubviews() {
		let screen_width = UIScreen.main.bounds.size.width
		
		topBackground = UIView.init(frame: CGRect.init(x: 0, y: -20, width: screen_width, height: 20))
		self.addSubview(topBackground!)
		
//		leftBtn = UIButton.init(text: "Back", fontSize: 16, textColor: UIColor.black, background: UIColor.white)
		leftBtn = UIButton.init()
		leftBtn?.setImage(UIImage.init(named: "nav_back_theme"), for: .normal)
		self.addSubview(leftBtn!)
		leftBtn!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.left.equalTo()(self)?.offset()(10)
			make.centerY.equalTo()(self)
			make.size.mas_equalTo()(CGSize.init(width: 44, height: 44))
		})
		leftBtn?.addTarget(self, action: #selector(self.didLeftBtnClick), for: .touchUpInside)
		
		rightBtn = UIButton.init(text: "Save", fontSize: 16, textColor: UIColor.black, background: MXSNothing.shared)
		self.addSubview(rightBtn!)
		rightBtn!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.right.equalTo()(self)?.offset()(-10)
			make.centerY.equalTo()(self)
			make.size.mas_equalTo()(CGSize.init(width: 44, height: 44))
		})
		
		titleLabel = UILabel.init(text:"Title", fontSize:18, textColor:UIColor.black, alignment:.left)
		self.addSubview(titleLabel!)
		titleLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make!.center.equalTo()(self)
		})
	}
	
	//notifies
	@objc func didLeftBtnClick () {
		controller?.didNavBarLeftClick()
	}
	
	//actions
	//title
	public func setTitle (value:Any, attr:String) {
		if attr == kNAVAttrArgsText {
			titleLabel?.text = value as? String
		} else if attr == kNAVAttrArgsTextColor {
			titleLabel?.textColor = value as! UIColor
		} else if attr == kNAVAttrArgsFont {
			titleLabel?.font = UIFont.systemFont(ofSize: value as! CGFloat)
		}
	}
	
	//left-right btn
	public func setLeftImgBtn (imgName:String) {
		leftBtn?.setImage(UIImage.init(named: imgName), for: .normal)
	}
	public func setRightImgBtn (imgName:String) {
		rightBtn?.setImage(UIImage.init(named: imgName), for: .normal)
	}
	public func setLeftTextBtn (text:String) {
		leftBtn?.setTitle(text, for: .normal)
	}
	public func setRightTextBtn (text:String) {
		rightBtn?.setTitle(text, for: .normal)
	}
	public func replaceLeftBtn (btn:UIButton) {
		leftBtn = btn
	}
	public func replaceRightBtn (btn:UIButton) {
		rightBtn = btn
	}
	
	public func hideLeftBtn() {
		leftBtn?.isHidden = true
	}
	public func hideRightBtn () {
		rightBtn?.isHidden = true
	}
	public func showLeftBtn() {
		leftBtn?.isHidden = false
	}
	public func showRightBtn () {
		rightBtn?.isHidden = false
	}
	
	//background
	public func setBackground ( color:UIColor) {
		self.backgroundColor = color
		topBackground?.backgroundColor = color
	}
	
}
