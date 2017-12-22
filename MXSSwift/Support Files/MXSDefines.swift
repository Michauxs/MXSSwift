//
//  MXSDefines.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH =							UIScreen.main.bounds.width
let SCREEN_HEWGHT =							UIScreen.main.bounds.height
let SCREEN_SCALE =							UIScreen.main.scale

let STATUS_BAR_H: CGFloat =					20
let NAV_BAR_H: CGFloat =					44
let S_N_BAR_H: CGFloat =					64
let TAB_BAR_H: CGFloat =					49
let BTM_COMMON_H: CGFloat =					49


let kNAVAttrArgsText =						"text"
let kNAVAttrArgsFont =						"font"
let kNAVAttrArgsTextColor =					"text_color"
//let kNAVAttrArgsText =					"text"



enum WeatherState: Int {
	case 晴 = 10
	case 多云 = 20
	case 阴 = 21
	case 小雨 = 30
	case 中雨 = 31
	case 大雨 = 32
	case 阵雨 = 33
	case 小雪 = 40
	case 中雪 = 41
	case 大雪 = 42
	case 小雨夹雪 = 43
	case 雾 = 50
}


func MXSLog(_ args:Any, _ sign:String = "MXSSwift") {
	#if DEBUG
		print(Date.init(), sign, ":", args)
	#endif
}
