//
//  MXSHomeVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSHomeVC: MXSBaseVC {
	
	
	
	override func receiveArgsBeBack(args: Any) {
		print("MXSHomeVC receive back : " + (args as! String))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.darkGray;
		
		super.bindingNavBar()
		super.bindingTableView()
		
		let data_arr = ["123", "456", "456", "456", "456"]
		TableView?.dlg?.queryData = data_arr
		
		let btn = UIButton.init(text: "Push", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(btn)
		btn.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.left.equalTo()(view)?.offset()(30)
			make.top.equalTo()(NavBar?.mas_bottom)?.offset()(130)
			make.size.mas_equalTo()(CGSize.init(width: 120, height: 40))
		}
		btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
		
		let exchangeBtn = UIButton.init(text: "Action", fontSize: 18, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(exchangeBtn)
		exchangeBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.left.equalTo()(view)?.offset()(30)
			make.top.equalTo()(view)?.offset()(130)
			make.size.mas_equalTo()(CGSize.init(width: 120, height: 40))
		}
		exchangeBtn.addTarget(self, action: #selector(self.exBtnClick), for: .touchUpInside)
	}
	
	//layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.rightBtn?.isHidden = true
		NavBar?.leftBtn?.isHidden = true
	}
	override func TableLayout() {
		super.TableLayout()
		TableView!.mas_makeConstraints { (make:MASConstraintMaker!) in
			make?.edges.equalTo()(view)?.insets()(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: TAB_BAR_H, right: 0))
		}
		TableView?.register(cellName: "MXSHomeCell", delegate: MXSTableDlg(), vc: self, rowHeight:50)
	}
	
	//acions
	@objc func btnClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSNoteVC(), args: kMXSNil)
	}
	
	@objc func exBtnClick() {
//		let btn = UIButton.init(text: "Exchange", fontSize: 14, textColor: UIColor.black, background: kMXSNil)
//		NavBar?.replaceRightBtn(btn: btn)
		
		TableView?.reloadData()
		
//		let para = ["phone":"17600365924"]
//		print("_____start01______")
//		MXSNetWork.shared.requestRemote(route: "", para:para, completeBlock: { result in
//			print("_____end01______")
//			print(result)
//		})
//		print("_____continue01______")
		
//		//并行测试
//		print("_____start02______")
//		MXSNetWork.shared.requestRemote(route: "", completeBlock: { result in
//			print("_____end02______")
//			print(result)
//		})
//		print("_____continue02______")
	}
	
}
