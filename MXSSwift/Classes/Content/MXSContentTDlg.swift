//
//  MXSContentCDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSContentTDlg: MXSTableDlg {
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MXSContentCell", for: indexPath) as! MXSContentCell
		cell.cellData = queryData?[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return rowHeight!
	}
	
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
}
