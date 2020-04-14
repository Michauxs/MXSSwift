//
//  MXSFoundVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSFoundVC: MXSBaseVC {
    
    var imageNameList : MXSTableView?
    
    override func receiveArgsBeBack(args: Any) {
        let index = MXSSingletonCmd.shared.FileImageNams.index(of: args as! String)
        imageNameList?.scrollToRow(at: IndexPath.init(row: index!, section: 0), at: .bottom, animated: true)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad();
        view.backgroundColor = UIColor.darkGray;
		
        imageNameList = MXSTableView.init(frame: .zero, style: .plain)
        imageNameList?.register(cellNames: [ "MXSImageNameCell"], delegate: MXSFoundTDlg(), vc: self)
        view.addSubview(imageNameList!)
        imageNameList?.snp.makeConstraints({ (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0));
        })
        
        MXSSingletonCmd.shared.FileImageNams = MXSFileStorageCmd.shared.enumImagesFileName()
        imageNameList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams;
        imageNameList?.mj_header = MJRefreshStateHeader.init(refreshingBlock: {
            MXSSingletonCmd.shared.FileImageNams = MXSFileStorageCmd.shared.enumImagesFileName()
            self.imageNameList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams;
            OperationQueue().addOperation {
                self.imageNameList!.reloadData()
                self.imageNameList!.mj_header.endRefreshing()
            }
        })
//        imageNameList!.header = JRefreshStateHeader.headerWithRefreshingBlock({[weak self] in
//            MXSSingletonCmd.shared.FileImageNams = MXSFileStorageCmd.shared.enumImagesFileName()
//            self?.imageNameList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams;
//
//            DispatchQueue.main.async {
//                self?.imageNameList!.reloadData()
//                self?.imageNameList!.header?.endRefreshing()
//            }
//        })
        imageNameList?.isHidden = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        view.addGestureRecognizer(pinchGesture)
	}
    
    @objc func handlePinchGesture (pinch:UIPinchGestureRecognizer) {
        let factor = pinch.scale
        if factor > 3 {
            imageNameList?.isHidden = false
        } else if factor < 0.3 {
            imageNameList?.isHidden = true
        }
    }
    
    @objc override func tableDidSelectedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let name = imageNameList?.dlg?.queryData![indexPath.row]
        MXSVCExchangeCmd.shared.PresentVC(self, dest: MXSShowImgVC(), args: name as Any)
    }
    
    
    @objc override func tableDidDeletedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let name = imageNameList?.dlg?.queryData![indexPath.row]
        MXSFileStorageCmd.shared.delImageWithName(name as! String)
        
        MXSSingletonCmd.shared.FileImageNams.remove(at: indexPath.row)
        imageNameList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams
        imageNameList?.deleteRows(at: [indexPath], with: .left)
    }
}
