//
//  MXSTableView.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import Refresher

class MXSTableView: UITableView {

	var dlg : MXSTableDlg?
    var controller : MXSBaseVC?
	
	override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: .zero, style: style)
        
        backgroundColor = UIColor.lightBlack
        separatorStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//    init(frame: CGRect, style: UITableViewStyle, vc: MXSBaseVC) {
//        super.init(frame: frame, style: style)
//        backgroundColor = UIColor.lightBlack
//        separatorStyle = .none
//    }
    
	func register(cellNames:Array<String>, delegate:MXSTableDlg, vc:MXSBaseVC) {
		
		let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        for cellName in cellNames {
            let cellClass : AnyClass = NSClassFromString(namespace + "." + cellName)!
            register(cellClass, forCellReuseIdentifier: cellName)
        }
//		register(MXSHomeCell.classForCoder(), forCellReuseIdentifier: cellName)
		
		dlg = delegate
		self.delegate = dlg
		self.dataSource = dlg
		dlg?.controller = vc
		dlg?.cellNames = cellNames
	}
	
	
}
