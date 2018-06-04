//
//  MXSProfileDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 23/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSProfileDlg: MXSTableDlg {
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:MXSProfileCell = tableView.dequeueReusableCell(withIdentifier: cellName!, for: indexPath) as! MXSProfileCell
		cell.cellData = queryData![indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 64
	}

//	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		return 44
//	}
//
//	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		let head = UIView.init()
//		let title = UILabel.init(text: "User Profile", fontSize: 14, textColor: UIColor.black, alignment: .left)
//		head.addSubview(title)
//		title.mas_makeConstraints { (make:MASConstraintMaker!) in
//			make.left.equalTo()(head)?.offset()(15)
//			make.centerY.equalTo()(head)
//		}
//		return head
//	}
}
