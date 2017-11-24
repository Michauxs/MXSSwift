//
//  MXSDefines.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation

let SCREEN_WIDTH =							UIScreen.main.bounds.width
let SCREEN_HEWGHT =							UIScreen.main.bounds.height
let SCREEN_SCALE =							UIScreen.main.scale

let STATUS_BAR_H:CGFloat =					20
let NAV_BAR_H:CGFloat =						44
let S_N_BAR_H:CGFloat =						64
let TAB_BAR_H:CGFloat =						49
let BTM_COMMON_H:CGFloat =					49

let kNAVAttrArgsText =						"text"
let kNAVAttrArgsFont =						"font"
let kNAVAttrArgsTextColor =					"text_color"
//let kNAVAttrArgsText =					"text"


let kMXSNil = 								"nil"


func MXSLog(_ args:Any) {
	#if DEBUG
		print(Date.init(), ":", args)
	#endif
}
