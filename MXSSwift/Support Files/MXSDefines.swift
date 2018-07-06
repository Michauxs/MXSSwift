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
let SCREEN_HEIGHT =							UIScreen.main.bounds.height
let SCREEN_SCALE =							UIScreen.main.scale

let STATUS_BAR_H: CGFloat =					20
let NAV_BAR_H: CGFloat =					44
let S_N_BAR_H: CGFloat =					64
let TAB_BAR_H: CGFloat =					49
let BTM_COMMON_H: CGFloat =					49


let kMXSDocumentsDirectory =                "/Documents"
let kMXSLibraryDirectory =                  "/Library"
let kMXSSystemDataDirectory =               "/SystemData"
let kMXSTmpDirectory =                      "/tmp"
let kMXSPreferencesDirectory =              "/Preferences"

let kNAVAttrArgsText =						"text"
let kNAVAttrArgsFont =						"font"
let kNAVAttrArgsTextColor =					"text_color"
//let kNAVAttrArgsText =					"text"


let kMXSWeathers =							["晴", "多云", "阴", "小雨", "中雨", "大雨", "阵雨", "小雪", "中雪", "大雪", "小雨夹雪", "雾"]



func MXSLog(_ args:Any, _ sign:String = "MXSSwift") {
	#if DEBUG
		print(Date.init(), sign, ":", args)
	#endif
}
