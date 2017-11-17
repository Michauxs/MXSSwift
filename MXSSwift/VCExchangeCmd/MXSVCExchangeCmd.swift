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
		if !(args is MXSNothing) {
			dest.receiveArgsBePost(args: args)
		}
		dest.hidesBottomBarWhenPushed = true
		sourse.navigationController?.pushViewController(dest, animated: true)
		
	}
	
	func SourseVCPop (sourse:MXSBaseVC, args:Any) {
		sourse.navigationController?.popViewController(animated: true)
		let pop = sourse.navigationController?.viewControllers.last as! MXSBaseVC
		if !(args is MXSNothing) {
			pop.receiveArgsBeBack(args:args)
		}
	}
	
	func SourseVCPopToDest(sourse:MXSBaseVC, dest:MXSBaseVC, args:Any) {
		for vc in (sourse.navigationController?.viewControllers)! {
			if vc.isKind(of: object_getClass(dest)!) {
				
				sourse.navigationController?.popToViewController(vc, animated: true)
				if !(args is MXSNothing) {
					(vc as! MXSBaseVC).receiveArgsBeBack(args:args)
				}
			}
		}
	}
	func SourseVCPopToRoot(sourse:MXSBaseVC, args:Any) {
		sourse.navigationController?.popToRootViewController(animated: true)
		let pop = sourse.navigationController?.viewControllers.last as! MXSBaseVC
		if !(args is MXSNothing) {
			pop.receiveArgsBeBack(args:args)
		}
	}
}
