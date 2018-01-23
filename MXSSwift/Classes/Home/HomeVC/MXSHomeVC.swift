//
//  MXSHomeVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSHomeVC: MXSBaseVC {
	
	var fileNameList : Array<String>?
	
	//MARK:life cycle
	override func receiveArgsBeBack(args: Any) {
		MXSLog("MXSHomeVC receive back : " + (args as! String))
		TableView?.reloadData()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.darkGray;
		
		super.bindingNavBar()
		super.bindingTableView(style: .plain)
		
		fileNameList = MXSFileStorageCmd.shared.enumVideoFileNameList()
		TableView?.dlg?.queryData = fileNameList
		
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
		NavBar?.titleLabel?.text = "Local Media"
		NavBar?.rightBtn?.setTitle("Add", for: .normal)
		NavBar?.rightBtn?.isHidden = true
		NavBar?.leftBtn?.isHidden = true
	}
	
	override func TableLayout() {
		super.TableLayout()
		TableView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		})
		TableView?.register(cellName: "MXSHomeCell", delegate: MXSHomeDlg(), vc: self)
		TableView?.addPullToRefreshWithAction {
			OperationQueue().addOperation {
				self.loadNewData()
			}
		}
		
	}
	
	//MARK:acions
	@objc func loadNewData() {
		
		fileNameList = MXSFileStorageCmd.shared.enumVideoFileNameList()
		TableView?.dlg?.queryData = fileNameList
		
		OperationQueue.main.addOperation {
			self.TableView?.reloadData()
			self.TableView?.stopPullToRefresh()
		}
	}
	@objc func loadMoreData() {
		fileNameList = MXSFileStorageCmd.shared.enumVideoFileNameList()
		TableView?.dlg?.queryData = fileNameList
		
		TableView?.reloadData()
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
		
	}
	
	override func tableSelectedRowAt(_ indexPath: IndexPath) {
		let videoName = TableView?.dlg?.queryData![indexPath.row]
//		MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSAVPlayVC(), args: videoName as Any)
		MXSVCExchangeCmd.shared.PresentVC(self, dest: MXSAVPlayVC(), args: videoName as Any)
	}
	
	override func tableDeletedRowAt(_ indexPath: IndexPath) {
		let name = fileNameList![indexPath.row]
		
		let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		try? FileManager.default.removeItem(atPath: docuDir.first!+"/"+name)
		
		fileNameList?.remove(at: indexPath.row)
		TableView?.dlg?.queryData = fileNameList
		TableView?.deleteRows(at: [indexPath], with: .left)
	}
	
}
