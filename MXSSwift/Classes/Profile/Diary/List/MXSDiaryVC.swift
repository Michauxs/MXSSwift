//
//  MXSDiaryVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSDiaryVC: MXSBaseVC {
	
	//MARK:life cycle
	override func receiveArgsBeBack(args: Any) {
		MXSLog("MXSDiaryVC receive back : " + (args as! String))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.darkGray;
		
		super.bindingNavBar()
		super.bindingTableView(style: .plain)
		
		let data_arr = MXSDiary.fetchDiaryObjects()
		TableView?.dlg?.queryData = data_arr
		
		let btn = UIButton.init(text: "Action", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(btn)
		btn.snp.makeConstraints { (make) in
			make.left.equalTo(view).offset(30)
			make.bottom.equalTo(view).offset(-30-TAB_BAR_H)
			make.size.equalTo(CGSize.init(width: 120, height: 40))
		}
		btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
		btn.isHidden = true
		
	}
	
	//MARK:layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.titleLabel?.text = "Diary List"
		NavBar?.rightBtn?.setTitle("Add", for: .normal)
	}
	
	override func TableLayout() {
		super.TableLayout()
		TableView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})
		TableView?.register(cellName: "MXSDiaryCell", delegate: MXSDiaryDlg(), vc: self, rowHeight:0)
		TableView?.addPullToRefreshWithAction {
			OperationQueue().addOperation {
				self.loadNewData()
			}
		}
	}
	
	//MARK:acions
	@objc func loadNewData() {
		let data_arr = MXSDiary.fetchDiaryObjects()
		TableView?.dlg?.queryData = data_arr
		TableView?.reloadData()
		OperationQueue.main.addOperation {
			self.TableView?.stopPullToRefresh()
		}
		
	}
	@objc func loadMoreData() {
		let data_arr = MXSDiary.fetchDiaryObjects()
		TableView?.dlg?.queryData = data_arr
		TableView?.reloadData()
		
	}
	
	
	//MARK:acions
	@objc func btnClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSNoteVC(), args: MXSNothing.shared)
	}
	
	@objc func exBtnClick() {
		TableView?.reloadData()
		
	}
	
	
	//MARK:notifies
	override func didNavBarRightClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSShowDiaryVC(), args: MXSNothing.shared)
	}
	
	override func tableSelectedRowAt(_ indexPath: IndexPath) {
		
		let diary = TableView?.dlg?.queryData![indexPath.row]
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSEditDiaryVC(), args: diary as Any)
	}
}
