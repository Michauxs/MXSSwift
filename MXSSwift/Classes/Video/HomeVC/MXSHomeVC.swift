//
//  MXSHomeVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSHomeVC: MXSBaseVC {
	
	var fileNameList : Dictionary<String, Array<String>>?
    var videoesTable : MXSTableView?
    var keyForHide : String? = "normal"
    
	//MARK:life cycle
	override func receiveArgsBeBack(args: Any) {
		MXSLog("MXSHomeVC receive back : " + (args as! String))
		 videoesTable?.reloadData()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.darkGray;
		
        videoesTable = MXSTableView.init(frame: .zero, style: .plain)
        view.addSubview(videoesTable!)
        videoesTable?.snp.makeConstraints({ (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets.init(top: STATUS_BAR_H, left: 0, bottom: 0, right: 0))
        })
        videoesTable?.register(cellNames: ["MXSHomeCell"], delegate: MXSHomeDlg(), vc: self)
        videoesTable?.mj_header = MJRefreshStateHeader.init(refreshingBlock: {
            OperationQueue().addOperation {
                self.loadNewData()
            }
        })
//        videoesTable?.header = JRefreshStateHeader.headerWithRefreshingBlock({[weak self] in
//            OperationQueue().addOperation {
//                self?.loadNewData()
//            }
//        })
        
        fileNameList = MXSFileStorageCmd.shared.enumVideoFileNameList()
        videoesTable?.dlg?.queryData = fileNameList?[keyForHide!]
		
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
        
        view.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        view.addGestureRecognizer(pinchGesture)
        
    }
    
    @objc func handlePinchGesture (pinch:UIPinchGestureRecognizer) {
        let factor = pinch.scale
        let state = pinch.state
        if factor > 3 && state == UIGestureRecognizerState.ended {
            MXSLog("---")
            keyForHide = "hidden"
            reloadDataWithKey()
        } else if factor < 0.3 && state == UIGestureRecognizerState.ended {
            keyForHide = "normal"
            reloadDataWithKey()
        }
        
    }
	
    func reloadDataWithKey () {
        videoesTable?.dlg?.queryData = fileNameList?[keyForHide!]
        videoesTable?.reloadData()
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
		
	}
	
	//MARK:acions
	@objc func loadNewData() {

		fileNameList = MXSFileStorageCmd.shared.enumVideoFileNameList()
        videoesTable?.dlg?.queryData = fileNameList?[keyForHide!]
		
		OperationQueue.main.addOperation {
			self.videoesTable?.reloadData()
            self.videoesTable?.mj_header.endRefreshing()
		}
	}
	
	
	@objc func btnClick() {
		MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSNoteVC(), args: MXSNothing.shared)
	}
	
	@objc func exBtnClick() {
//		let btn = UIButton.init(text: "Exchange", fontSize: 14, textColor: UIColor.black, background: kMXSNil)
//		NavBar?.replaceRightBtn(btn: btn)
		
		 videoesTable?.reloadData()
		
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
    
    
    @objc func hideCellItemWith (args:Any) {
        let row = args
        MXSLog("vc hide: " + "\(row)")
        
        let list = fileNameList?[keyForHide!]
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let name = list![indexPath.row]
        MXSDataFileCmd.init().appendPreference(name, key: kMXSVideoNamesHide)
    }
    
    @objc override func tableDidDeletedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        
        var list = fileNameList?[keyForHide!]
        let name = list![indexPath.row]
        let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        try? FileManager.default.removeItem(atPath: docuDir.first!+"/"+name)
        
        list?.remove(at: indexPath.row)
        videoesTable?.dlg?.queryData = list
        videoesTable?.deleteRows(at: [indexPath], with: .left)
    }
    
    @objc override func tableDidSelectedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let videoName = videoesTable?.dlg?.queryData![indexPath.row]
        MXSVCExchangeCmd.shared.PresentVC(self, dest: MXSAVPlayVC(), args: videoName as Any)
    }
}
