//
//  MXSBaseVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSBaseVC: UIViewController, MXSVCPtc {

	var NavBar : MXSNavBar?
	
//	let receiveCmdArgsPost = { (args:Any)  in
//	}
//	let receiveCmdArgsBack = { (args:Any)  in
//	}
	
	public func receiveArgsBePost(args:Any) {
		print("no subVC received args be post")
	}
	public func receiveArgsBeBack(args:Any) {
		print("no subVC received args be back")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.init(white: 0.3, alpha: 1)
    }

	public func bindingNavBar () {
		NavBar = MXSNavBar.init(vc: self)
		view.addSubview(NavBar!)
		NavBar?.setBackground(color: UIColor.white)
	}
	
	//navbar notify
	public func didNavBarLeftClick () {
		print("BaseVC didNavBarLeftClick")
	}
	public func didNavBarRightClick () {
		print("BaseVC didNavBarRightClick")
	}
}
