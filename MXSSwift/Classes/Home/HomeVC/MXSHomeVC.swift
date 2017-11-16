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
		self.view.backgroundColor = UIColor.darkGray;
		
		
		NavBar = MXSNavBar.init(vc: self)
		self.view.addSubview(NavBar!)
		NavBar?.setBackground(color: UIColor.white)
		NavBar?.hideLeftBtn(ishidden: true)
		NavBar?.hideRightBtn(ishidden: true)
		
		let btn = UIButton.init(type: UIButtonType.contactAdd)
		view .addSubview(btn)
		btn.frame = CGRect.init(x: 40, y: 80, width: 50, height: 30)
		btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
	}
	
	@objc func btnClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSNoteVC(), args: "0")
	}
	
	
}
