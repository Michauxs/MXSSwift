//
//  MXSDiaryVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import MJRefresh

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
		NavBar?.titleLabel?.text = "Diary"
		NavBar?.rightBtn?.setTitle("Add", for: .normal)
//		NavBar?.rightBtn?.isHidden = true
//		NavBar?.leftBtn?.isHidden = true
	}
	
	override func TableLayout() {
		super.TableLayout()
		TableView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})
		TableView?.register(cellName: "MXSDiaryCell", delegate: MXSDiaryDlg(), vc: self, rowHeight:0)
		
		TableView?.mj_header = MJRefreshNormalHeader.init()
		TableView?.mj_header.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
		
		TableView?.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
//		TableView?.mj_footer.
//		TableView?.mj_footer = MJRefreshAutoStateFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
	}
	
	//MARK:acions
	@objc func loadNewData() {
		let data_arr = MXSDiary.fetchDiaryObjects()
		TableView?.dlg?.queryData = data_arr
		TableView?.reloadData()
		
		TableView?.mj_header.endRefreshing()
	}
	@objc func loadMoreData() {
		let data_arr = MXSDiary.fetchDiaryObjects()
		TableView?.dlg?.queryData = data_arr
		TableView?.reloadData()
		
		TableView?.mj_footer.endRefreshing()
//		TableView?.mj_footer.isHidden = true
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
//		MXSDiary.addDiaryWithDictionary(["key":"1"])
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSShowDiaryVC(), args: MXSNothing.shared)
	}
	
	override func tableSelectedRowAt(indexPath: IndexPath) {
		
		let diary = TableView?.dlg?.queryData![indexPath.row]
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSEditDiaryVC(), args: diary as Any)
	}
}
