//
//  MXSDiaryVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSDiaryVC: MXSBaseVC {
	
	var diaryData : Array<MXSDiary>?
	
	//MARK:life cycle
	override func receiveArgsBeBack(args: Any) {
		MXSLog("MXSDiaryVC receive back : " + (args as! String))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.darkGray;
		
		super.bindingNavBar()
		super.bindingTableView(style: .plain)
		
		diaryData = MXSDiary.fetchDiaryObjects()
		TableView?.dlg?.queryData = diaryData
		
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
		TableView?.register(cellNames: ["MXSDiaryCell"], delegate: MXSDiaryDlg(), vc: self)
        TableView?.header = JRefreshStateHeader.headerWithRefreshingBlock({[weak self] in
            guard let `self` = self else {return}
//            OperationQueue().addOperation {
//            }
            self.loadNewData()
        })
        TableView?.header?.beginRefreshing()
    }
    
    //MARK:acions
    @objc func loadNewData() {
        diaryData = MXSDiary.fetchDiaryObjects()
        TableView?.dlg?.queryData = diaryData
        
        OperationQueue.main.addOperation {
            self.TableView?.reloadData()
            self.TableView?.header?.endRefreshing()
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
	
    @objc override func tableDidSelectedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let diary = TableView?.dlg?.queryData![indexPath.row]
        MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSEditDiaryVC(), args: diary as Any)
    }
	
    
    @objc override func tableDidDeletedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let diary = diaryData![indexPath.row]
        //        diaryData?.remove(at: indexPath.row)
        MXSDiary.removeDiaryObjects([diary])
        
        diaryData = MXSDiary.fetchDiaryObjects()
        TableView?.dlg?.queryData = diaryData
        TableView?.deleteRows(at: [indexPath], with: .left)
    }
}
