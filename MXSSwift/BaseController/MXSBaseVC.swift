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
	
	let receiveCmdArgsPost = { (args:Any)  in
		
	}
	let receiveCmdArgsBack = { (args:Any)  in
		
	}
	
	public func receiveArgsBePost(args:Any) {
		
	}
	public func receiveArgsBeBack(args:Any) {
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.init(white: 0.3, alpha: 1)
		
    }

	public func didNavBarLeftClick () {
		print("BaseVC didNavBarLeftClick")
	}
}
