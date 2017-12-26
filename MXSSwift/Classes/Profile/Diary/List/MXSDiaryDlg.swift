//
//  MXSDiaryDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSDiaryDlg: MXSTableDlg {
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: cellName!, for: indexPath) as! MXSDiaryCell
		cell.cellData = queryData?[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "Delete"
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		MXSDiary.removeDiaryObjects([queryData![indexPath.row] as! MXSDiary])
//		tableView.reloadRows(at: [indexPath], with: .none)
		tableView.reloadData()
		controller?.tableDeletedRowAt(indexPath)
	}
	
}
