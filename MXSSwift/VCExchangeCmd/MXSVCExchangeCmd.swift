//
//  MXSVCExchangeCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSVCExchangeCmd: NSObject {
	
	static let shared = MXSVCExchangeCmd()
	
	func SourseVCPushDestVC(sourse:MXSBaseVC, dest:MXSBaseVC, args:Any) {
		
		dest.receiveArgsBePost(args: args)
		dest.hidesBottomBarWhenPushed = true
		sourse.navigationController?.pushViewController(dest, animated: true)
		
	}
	
	func SourseVCPop (sourse:MXSBaseVC, args:Any) {
		sourse.navigationController?.popViewController(animated: true)
		let pop = sourse.navigationController?.viewControllers.last as! MXSBaseVC
		pop.receiveArgsBeBack(args:args)
	}
}
