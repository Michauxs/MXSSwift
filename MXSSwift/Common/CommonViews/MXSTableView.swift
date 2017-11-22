//
//  MXSTableView.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSTableView: UITableView {

	var dlg : MXSTableDlg?
	
	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: .zero, style: .grouped)
	}
	
//	convenience init(frame: CGRect, style: UITableViewStyle, vc:MXSBaseVC) {
//		self.init(frame: .zero, style: .grouped)
//		controller = vc
//	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func register(cellName:String, delegate:MXSTableDlg, vc:MXSBaseVC, rowHeight:CGFloat = 64) {
		
		register(NSClassFromString(cellName), forCellReuseIdentifier: cellName)
		dlg = delegate
		self.delegate = dlg
		self.dataSource = dlg
		dlg?.cellName = cellName
		dlg?.rowHeight = rowHeight
	}
	
	
}
