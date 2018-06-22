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
    var videoesTable : MXSTableView?
    
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
        videoesTable?.addPullToRefreshWithAction {
            OperationQueue().addOperation {
                self.loadNewData()
            }
        }
        fileNameList = MXSFileStorageCmd.shared.enumVideoFileNameList()
        videoesTable?.dlg?.queryData = fileNameList
        videoesTable?.isHidden = true
		
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
        if factor > 3 {
            videoesTable?.isHidden = false
        } else if factor < 0.3 {
            videoesTable?.isHidden = true
        }
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
        videoesTable?.dlg?.queryData = fileNameList
		
		OperationQueue.main.addOperation {
			self.videoesTable?.reloadData()
			self.videoesTable?.stopPullToRefresh()
		}
	}
	@objc func loadMoreData() {
		fileNameList = MXSFileStorageCmd.shared.enumVideoFileNameList()
        videoesTable?.dlg?.queryData = fileNameList
		
        videoesTable?.reloadData()
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
	
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
	
	//MARK:notifies
	override func didNavBarRightClick() {
		
	}
	
	override func tableSelectedRowAt(_ indexPath: IndexPath) {

		let videoName = videoesTable?.dlg?.queryData![indexPath.row]
//		MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSAVPlayVC(), args: videoName as Any)
		MXSVCExchangeCmd.shared.PresentVC(self, dest: MXSAVPlayVC(), args: videoName as Any)
	}
	
	override func tableDeletedRowAt(_ indexPath: IndexPath) {
		let name = fileNameList![indexPath.row]
		
		let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		try? FileManager.default.removeItem(atPath: docuDir.first!+"/"+name)
		
		fileNameList?.remove(at: indexPath.row)
		videoesTable?.dlg?.queryData = fileNameList
		videoesTable?.deleteRows(at: [indexPath], with: .left)
	}
	
}
