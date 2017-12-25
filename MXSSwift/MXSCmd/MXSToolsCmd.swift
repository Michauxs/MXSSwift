//
//  MXSToolsCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 25/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSToolsCmd: NSObject {
	
	static let shared = MXSToolsCmd()
	
	lazy var defaultFormatter : DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.init(identifier: "UTC")
		formatter.locale = Locale.init(identifier: "zh_CN")
		formatter.dateFormat = "yyyy-MM-dd"
		
		return formatter
	}()
	
	public func dateConvertString(_ date:Date, defFormat:String = "yyyy-MM-dd") -> String {
		if defFormat == "yyyy-MM-dd" {
			return self.defaultFormatter.string(from: date)
			
		} else {
			let formatter = DateFormatter()
			formatter.timeZone = TimeZone.init(identifier: "UTC")
			formatter.locale = Locale.init(identifier: "zh_CN")
			formatter.dateFormat = defFormat
			
			return formatter.string(from: date)
		}
	}
	
	
	public func stringConvertDate(_ str:String, defFormat:String = "yyyy-MM-dd") -> Date {
		if defFormat == "yyyy-MM-dd" {
			return self.defaultFormatter.date(from: str)!
			
		} else {
			
			let formatter = DateFormatter()
			formatter.timeZone = TimeZone.init(identifier: "UTC")
			formatter.locale = Locale.init(identifier: "zh_CN")
			formatter.dateFormat = defFormat
			
			return formatter.date(from: str)!
		}
	}
	
	
	public func transWeather(_ state:Int) -> String {
		var weather : String?
		
		if state/100 == 0 {
			weather = kMXSWeathers[state-10 < 0 ? 0 : state-10]
		} else {
			let first = kMXSWeathers[state/100 - 10]
			let last = kMXSWeathers[state%100 - 10]
			weather = first + "转" + last
		}
		
		if weather?.count == 0 {
			weather = "未记录天气"
		}
		
		return weather!
	}
}
