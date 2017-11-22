//
//  MXSHomeVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSHomeVC: MXSBaseVC {
	
	override func receiveArgsBeBack(args: Any) {
		print("MXSHomeVC receive back : " + (args as! String))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.darkGray;
		
		super.bindingNavBar()
		
		let btn = UIButton.init(text: "Action", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(btn)
		btn.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.left.equalTo()(view)?.offset()(30)
			make.top.equalTo()(NavBar?.mas_bottom)?.offset()(130)
			make.size.mas_equalTo()(CGSize.init(width: 120, height: 40))
		}
		btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
		
		let exchangeBtn = UIButton.init(text: "ExChange", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(exchangeBtn)
		exchangeBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.left.equalTo()(view)?.offset()(30)
			make.top.equalTo()(view)?.offset()(130)
			make.size.mas_equalTo()(CGSize.init(width: 120, height: 40))
		}
		exchangeBtn.addTarget(self, action: #selector(self.exBtnClick), for: .touchUpInside)
	}
	
	//layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.rightBtn?.isHidden = true
		NavBar?.leftBtn?.isHidden = true
	}
	
	//acions
	@objc func btnClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSNoteVC(), args: kMXSNil)
	}
	
	@objc func exBtnClick() {
//		let btn = UIButton.init(text: "Exchange", fontSize: 14, textColor: UIColor.black, background: kMXSNil)
//		NavBar?.replaceRightBtn(btn: btn)
		
		let block = MXSNetWork.shared.requestRemote(route: "")
		print(block as Any)
		
		print("_____end______")
//		MXSNetWork.shared.requestRemote()
		
	}
	
}
