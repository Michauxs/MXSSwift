//
//  MXSHomeDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 23/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSHomeDlg: MXSTableDlg {
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:MXSHomeCell = tableView.dequeueReusableCell(withIdentifier: cellName!, for: indexPath) as! MXSHomeCell
		cell.cellData = queryData?[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
}
