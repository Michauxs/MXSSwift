//
//  MXSVCPtc.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation

@objc protocol MXSVCPtc {
	
	@objc optional func ReceiveCmdArgsActionPost(args:Any)
	
	@objc optional func ReceiveCmdArgsActionBack(args:Any)
	
}
