//
//  MXSProfileVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSProfileVC: MXSBaseVC {
	
	var userImageView : UIImageView?
	var coverViewHeight : CGFloat = 150
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.random;
		
		super.bindingTableView()
		
		userImageView = UIImageView.init(image: UIImage.init(named: "default_user"))
		userImageView?.contentMode = UIViewContentMode.scaleAspectFill
		userImageView?.clipsToBounds = true
		TableView?.addSubview(userImageView!)
		userImageView!.snp.makeConstraints { (make) in
			make.bottom.equalTo(TableView!.snp.bottom)
			make.width.equalTo(SCREEN_WIDTH)
			make.centerX.equalTo(TableView!)
			make.height.equalTo(coverViewHeight)
		}
		
	}
	
	//MARK:layout
	override func TableLayout() {
		TableView!.snp.makeConstraints { (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
		}
		TableView?.contentInset = UIEdgeInsetsMake(coverViewHeight, 0, 0, 0)
		TableView?.register(cellName: "MXSProfileCell", delegate: MXSProfileDlg(), vc: self)
		
		TableView?.dlg?.queryData = ["Xcode Complete", "My Diray", "Fetch Diary", "AboutDongDa", "AppSetting"]
	}
	
	//MARK:notifies
	override func tableSelectedRowAt(_ indexPath: IndexPath) {
		if indexPath.row == 0 {
			MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSXcodePSVC(), args: MXSNothing.shared)
		} else if indexPath.row == 1 {
			MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSDiaryVC(), args: MXSNothing.shared)
			
		} else if indexPath.row == 2 {
//			let arr = MXSDiary.fetchDiaryObjects()
//			MXSLog(arr.count)
			
		} else if indexPath.row == 3 {
			
		} else if indexPath.row == 4 {
//			MXSDiary.findDiaryObjects2 {(fetch) in
//				let diary = fetch.first
//				MXSLog(diary!.diary_content as Any)
//			}
		}
	}
	
	override func tableDidScroll(offset_y: CGFloat) {
		let y = coverViewHeight + offset_y
		if y < 0 {
			userImageView!.snp.updateConstraints({ (make) in
				make.height.equalTo(-offset_y)
			})
		} else {
			
		}
		
	}
}
