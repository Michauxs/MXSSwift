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
		let self_height = self.bounds.size.height
		
		topBackground = UIView.init(frame: CGRect.init(x: 0, y: -20, width: screen_width, height: 20))
		self.addSubview(topBackground!)
		
		leftBtn = UIButton.init(frame: CGRect.init(x: 15, y: 0, width: 44, height: self_height))
		leftBtn?.setTitle("Back", for: .normal)
		leftBtn?.setTitleColor(UIColor.black, for: .normal)
		self.addSubview(leftBtn!)
		leftBtn?.addTarget(self, action: #selector(self.didLeftBtnClick), for: .touchUpInside)
		
		rightBtn = UIButton.init(frame: CGRect.init(x: screen_width - 15 - 44, y: 0, width: 44, height: self_height))
		rightBtn?.setTitle("Save", for: .normal)
		rightBtn?.setTitleColor(UIColor.black, for: .normal)
		self.addSubview(rightBtn!)
		
		titleLabel = UILabel.init(text:"Title", fontSize:18, textColor:UIColor.black, alignment:.left)
//		titleLabel = UILabel.init()
//		titleLabel?.text = "Title"
//		titleLabel?.textColor = UIColor.black
//		titleLabel?.font = UIFont.systemFont(ofSize: 18)
		self.addSubview(titleLabel!)
//		titleLabel?.center = CGPoint.init(x: self.center.x, y: self.center.y)
		titleLabel?.sizeToFit()
//		titleLabel?.frame = CGRect.init(x: (screen_width-(titleLabel?.bounds.size.width)!)*0.5, y: (44-(titleLabel?.bounds.size.height)!)*0.5, width: (titleLabel?.bounds.size.width)!, height: (titleLabel?.bounds.size.height)!)
		titleLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make!.center.equalTo()(self)
		})
	}
	
	//notifies
	@objc func didLeftBtnClick () {
		controller?.didNavBarLeftClick()
	}
	
	//actions
	public func setBackground ( color:UIColor) {
		self.backgroundColor = color
		topBackground?.backgroundColor = color
	}
	public func hideLeftBtn ( ishidden:Bool) {
		leftBtn?.isHidden = ishidden
	}
	public func hideRightBtn ( ishidden:Bool) {
		rightBtn?.isHidden = ishidden
	}
	
}
