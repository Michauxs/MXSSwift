//
//  MXSNetWork.swift
//  MXSSwift
//
//  Created by Alfred Yang on 21/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import Alamofire


class MXSNetWork : NSObject {
	
	#if DEBUG
		let RemoteRootURL = "http://altlys.com:9000/"
	#else
		let RemoteRootURL = "http://altlys.com:9000/"
	#endif
	
	static let shared = MXSNetWork.init()
	
	public func requestRemote(route:String, completeBlock:(Any) -> (Any)) {
		
		let para : Parameters = ["phone":"17600365924"]
		let headers: HTTPHeaders = [
			"Content-Type": "application/json",
			"Accept": "application/json"
		]
		
//		var args:Any?
		
		Alamofire.request( RemoteRootURL + "al/code/send", method: .post, parameters: para, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
			args = response.result.value
			completeBlock(args)
		}
//		return args as Any
	}
	
	let completeBlock:(Any) -> (Any) = {(args:Any)->Any in
		return args
	}
	
}
