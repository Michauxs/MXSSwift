//
//  MXSHomeVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import MJRefresh

class MXSHomeVC: MXSBaseVC {
	
	
	//MARK:life cycle
	override func receiveArgsBeBack(args: Any) {
		MXSLog("MXSHomeVC receive back : " + (args as! String))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.darkGray;
		
		super.bindingNavBar()
		super.bindingTableView(style: .plain)
		
		let data_arr = MXSDiary.fetchDiaryObjects()
//		let data_arr = ["车和日当午", "汗滴禾下土", "是指盘中餐", "粒粒皆辛苦", "23333"]
		TableView?.dlg?.queryData = data_arr
		
		let btn = UIButton.init(text: "Push", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(btn)
		btn.snp.makeConstraints { (make) in
			make.left.equalTo(view).offset(30)
			make.bottom.equalTo(view).offset(-30-TAB_BAR_H)
			make.size.equalTo(CGSize.init(width: 120, height: 40))
		}
		btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
		btn.isHidden = true
		
		let exchangeBtn = UIButton.init(text: "Action", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(exchangeBtn)
		exchangeBtn.snp.makeConstraints { (make) in
			make.right.equalTo(view).offset(-30)
			make.bottom.equalTo(view).offset(-30-TAB_BAR_H)
			make.size.equalTo(CGSize.init(width: 120, height: 40))
		}
		exchangeBtn.addTarget(self, action: #selector(self.exBtnClick), for: .touchUpInside)
		exchangeBtn.isHidden = true
	}
	
	//MARK:layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.titleLabel?.text = "首页"
		NavBar?.rightBtn?.setTitle("Add", for: .normal)
//		NavBar?.rightBtn?.isHidden = true
		NavBar?.leftBtn?.isHidden = true
	}
	
	override func TableLayout() {
		super.TableLayout()
		TableView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})
		TableView?.register(cellName: "MXSHomeCell", delegate: MXSHomeDlg(), vc: self, rowHeight:90)
//		TableView?.addPullToRefreshWithAction {
//			OperationQueue().addOperation {
//				sleep(2)
//				OperationQueue.main.addOperation {
//					self.TableView?.stopPullToRefresh()
//				}
//			}
//		}
		
		TableView?.mj_header = MJRefreshNormalHeader.init()
		TableView?.mj_header.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
		
//		TableView?.mj_footer = MJRefreshAutoNormalFooter.init()
//		TableView?.mj_footer = MJRefreshFooter.init()
//		TableView?.mj_footer = MJRefreshAutoFooter()
//		TableView?.mj_footer = MJRefreshBackFooter()
//		TableView?.mj_footer.setRefreshingTarget( self, refreshingAction: #selector(loadMoreData))
		TableView?.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
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
	}
	
	
	@objc func btnClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSNoteVC(), args: MXSNothing.shared)
	}
	
	@objc func exBtnClick() {
//		let btn = UIButton.init(text: "Exchange", fontSize: 14, textColor: UIColor.black, background: kMXSNil)
//		NavBar?.replaceRightBtn(btn: btn)
		
		TableView?.reloadData()
		
//		let para = ["phone":"17600365924"]
//		MXSLog("_____start01______")
//		MXSNetWork.shared.requestRemote(route: "", para:para, completeBlock: { result in
//			MXSLog("_____end01______")
//			MXSLog(result)
//		})
//		MXSLog("_____continue01______")
		
	}
	
	
	//MARK:notifies
	override func didNavBarRightClick() {
		MXSDiary.addDiaryWithDictionary(["key":"1"])
	}
	
	override func tableSelectedRowAt(indexPath: IndexPath) {
		btnClick()
	}
	
	
}
