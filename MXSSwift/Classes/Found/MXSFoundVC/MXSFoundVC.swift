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
        
        imageNameList!.addPullToRefreshWithAction {
            MXSSingletonCmd.shared.FileImageNams = MXSFileStorageCmd.shared.enumImagesFileName()
            self.imageNameList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams;
            
            DispatchQueue.main.async {
                self.imageNameList!.reloadData()
                self.imageNameList!.stopPullToRefresh()
            }
        }
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
    
    override func tableSelectedRowAt(_ indexPath: IndexPath) {
        let name = imageNameList?.dlg?.queryData![indexPath.row]
        MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSShowImgVC(), args: name as Any)
    }
    
    override func tableDeletedRowAt(_ indexPath: IndexPath) {
        let name = imageNameList?.dlg?.queryData![indexPath.row]
        MXSFileStorageCmd.shared.delImageWithName(name as! String)
        
        MXSSingletonCmd.shared.FileImageNams.remove(at: indexPath.row)
        imageNameList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams
        imageNameList?.deleteRows(at: [indexPath], with: .left)
    }
}
