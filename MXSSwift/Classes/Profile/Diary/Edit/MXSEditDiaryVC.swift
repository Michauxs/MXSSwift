//
//  MXSEditDiaryVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSEditDiaryVC: MXSBaseVC {

	var dateLabel : UILabel?
	var DiaryData : MXSDiary?
	
	override public func receiveArgsBePost(args:Any) {
		DiaryData = args as? MXSDiary
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bindingNavBar()
		bindingTableView()
		
		(TableView?.dlg as! MXSEditDiaryDlg).queryDataSub = DiaryData
    }
	
	//MARK:layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.titleLabel?.text = "Edit Diary"
	}
	
	override func TableLayout() {
		TableView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})
		TableView?.register(cellName: "MXSEditDiaryCell", delegate: MXSEditDiaryDlg(), vc: self, rowHeight: 0)
		
	}
	
	//MARK:notifies
	override func didNavBarRightClick() {
		
	}
	
	override func tableSelectedRowAt(indexPath: IndexPath) {
		
	}
}