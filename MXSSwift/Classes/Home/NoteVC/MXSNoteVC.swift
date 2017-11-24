//
//  MXSNoteVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSNoteVC: MXSBaseVC {
	
	override func receiveArgsBePost(args: Any) {
		let str = args as! String
		MXSLog("MXSNoteVC receive post : " + str)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		super.bindingNavBar()
	}
	
	override func didNavBarLeftClick () {
		MXSLog("MXSNoteVC didNavBarLeftClick")
		MXSVCExchangeCmd.shared.SourseVCPop(sourse: self, args: "1")
	}
	
}
