//
//  MXSFoundTDlg.swift
//  MXSSwift
//
//  Created by Sunfei on 2018/6/4.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSFoundTDlg: MXSTableDlg {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MXSImageNameCell = tableView.dequeueReusableCell(withIdentifier: cellName!, for: indexPath) as! MXSImageNameCell
        cell.cellData = queryData?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
