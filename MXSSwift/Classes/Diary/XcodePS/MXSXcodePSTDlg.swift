//
//  MXSXcodePSTDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 6/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSXcodePSTDlg: MXSTableDlg {

	var sections : Array<String>?
	
	var queryDataSub : Dictionary<String, Any>? {
		didSet {
			sections = Array(queryDataSub!.keys)
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (queryDataSub != nil) {
            
            return (queryDataSub![sections![section] as String] as! Array<Dictionary<String,Any>>).count
        } else {
        	return 0
        }
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MXSXcodePSCell = tableView.dequeueReusableCell(withIdentifier: (cellNames?.first)!, for: indexPath) as! MXSXcodePSCell
        cell.cellData = (queryDataSub![sections![indexPath.section] as String] as! Array<Dictionary<String,Any>>)[indexPath.row]
		return cell
	}
	
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
	
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		let head:MXSXcodeTableHeadView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MXSXcodeTableHeadView") as MXSXcodeTableHeadView

		let headerView = MXSXcodeTableHeadView(reuseIdentifier: "MXSXcodeTableHeadView")
		headerView.label?.text = sections?[section]
        return headerView
    }
	
}
