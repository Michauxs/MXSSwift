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
        let cell:MXSHomeCell = tableView.dequeueReusableCell(withIdentifier: (cellNames?.first)!, for: indexPath) as! MXSHomeCell
		cell.cellData = queryData?[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 54
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionHide = UITableViewRowAction.init(style: .normal, title: "hide") { action, indexPath in
            MXSLog("hide" + "\(indexPath.row)")
//            self.controller?.perform(NSSelectorFromString("hideCellItem"), with:indexPath.row)
            self.controller?.perform(NSSelectorFromString("hideCellItemWithArgs:"), with: indexPath.row)
            
//            self.controller?.perform(NSSelectorFromString("hideCellItem"), with)
        }
        let actionEdit = UITableViewRowAction.init(style: .normal, title: "Delet") { (action:UITableViewRowAction, indexPath:IndexPath) in
            MXSLog("Delet" + "\(indexPath.row)")
        }
        return [actionEdit, actionHide]
    }
}
