//
//  MXSTableDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit


class MXSTableDlg: NSObject, UITableViewDelegate, UITableViewDataSource {
	
	var queryData : Array<Any>?
	var cellName : String?
	var rowHeight : CGFloat?
	var controller : MXSBaseVC?
	
	
	func changeData(data:Array<Any>) {
		queryData = data
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (queryData?.count)!;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:MXSHomeCell = tableView.dequeueReusableCell(withIdentifier: cellName!, for: indexPath) as! MXSHomeCell
		cell.titleLabel?.text = queryData?[indexPath.row] as? String
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return rowHeight!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		controller?.tableSelectedRowAt(indexPath: indexPath)
	}
	
}
