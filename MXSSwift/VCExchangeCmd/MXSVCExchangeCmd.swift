//
//  MXSVCExchangeCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSVCExchangeCmd: NSObject {
//	class func shard() -> (MXSVCExchangeCmd) {
//
//	}
	
	static let shared = MXSVCExchangeCmd()
	
	func SourseVCPushDestVC(sourse:MXSBaseVC, dest:MXSBaseVC, args:Any) {
		
		sourse.navigationController?.pushViewController(dest, animated: true)
	}
	
	func demo() {
//		SourseVCPushDestVC(sourse: self, dest: self, args: nil)
	}
}
