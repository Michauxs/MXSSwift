//
//  MXSContTDlg.swift
//  MXSSwift
//
//  Created by Sunfei on 2018/6/6.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSContTDlg: MXSTableDlg {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
