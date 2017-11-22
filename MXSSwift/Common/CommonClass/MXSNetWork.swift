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
	
	let headers: HTTPHeaders = [
		"Content-Type": "application/json",
		"Accept": "application/json"
	]
	
	// MARK: singleton
	static let shared = MXSNetWork.init()
	
	public func requestRemote(route:String, para:Dictionary<String, Any>, completeBlock:@escaping (Any) -> Void) {
		
		Alamofire.request( RemoteRootURL + "al/code/send", method: .post, parameters: para, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
			completeBlock(response.result.value as Any)
		}
	}
	
	
	
}
