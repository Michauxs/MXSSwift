//
//  MXSHomeDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 23/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSHomeDlg: MXSTableDlg {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return rowHeight!
	}

}
