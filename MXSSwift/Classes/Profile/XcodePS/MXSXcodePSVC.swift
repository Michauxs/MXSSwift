//
//  MXSXcodePSVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 6/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSXcodePSVC: MXSBaseVC {

	var psData : Dictionary<String, Any>?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		bindingNavBar()
		bindingTableView()
		
		let path = Bundle.main.path(forResource: "xcode_complete", ofType: "json")
		let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path!))
		MXSLog(data as Any)
		do {
			let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
			psData = json as? Dictionary
            
            (TableView?.dlg as! MXSXcodePSTDlg).queryDataSub = json as? Dictionary
            
//            MXSLog(json as Any)
		} catch {
			MXSLog("error in data->object")
		}
		
    }

	//MARK:Layout
	override func NavBarLayout() {
		
	}
	
	override func TableLayout() {
		TableView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})
        TableView?.register(cellName: "MXSXcodePSCell", delegate: MXSXcodePSTDlg(), vc: self, rowHeight: 0)
	}
	
	
	
}
