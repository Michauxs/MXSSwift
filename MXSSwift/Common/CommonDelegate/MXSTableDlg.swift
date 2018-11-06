//
//  MXSTableDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

/*
*	子类注意事项：
		1.注册/获取cell都是通过 具体cell类的String，不能使用通用cell基类的名字String， 必须独自实现 cellForRowAt；
		2.自动高度UITableViewAutomaticDimension的cell 不能再实现heightForRowAt，所以此方法交由子类自行实现；
*/
class MXSTableDlg: NSObject, UITableViewDelegate, UITableViewDataSource {
	
	var queryData : Array<Any>?
	var cellNames : Array<String>?
	var controller : MXSBaseVC?
	
	
	func changeData(data:Array<Any>) {
		queryData = data
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (queryData != nil) ? (queryData?.count)! : 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: (cellNames?.first)!, for: indexPath)
        (cell as! MXSTableViewCell).cellData = queryData?[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = Dictionary<String, Any>.init(minimumCapacity: 2)
        info["indexPath"] = indexPath
        info["tableView"] = tableView
        self.controller?.perform(NSSelectorFromString("tableDidSelectedRowWithArgs:"), with: info)
	}
	
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return false
	}
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "Delete"
	}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var info = Dictionary<String, Any>.init(minimumCapacity: 2)
        info["indexPath"] = indexPath
        info["tableView"] = tableView
        self.controller?.perform(NSSelectorFromString("tableDidDeletedRowWithArgs:"), with: info)
	}
	
    
    
    
	//MARK:scrollview
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset_y = scrollView.contentOffset.y
		controller?.tableDidScroll(offset_y: offset_y)
	}
}
