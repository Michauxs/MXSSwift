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
		NavBar?.hideLeftBtn()
		NavBar?.hideRightBtn()
		
		let btn = UIButton.init(text: "Action", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(btn)
		btn.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.left.equalTo()(view)?.offset()(30)
			make.top.equalTo()(view)?.offset()(130)
			make.size.mas_equalTo()(CGSize.init(width: 120, height: 40))
		}
		btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
	}
	
	@objc func btnClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSNoteVC(), args: MXSNothing.shared)
	}
	
}
