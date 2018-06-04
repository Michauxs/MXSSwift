//
//  MXSFoundVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSFoundVC: MXSBaseVC {
    
    var imageList : MXSTableView?
    
	override func viewDidLoad() {
		super.viewDidLoad();
        view.backgroundColor = UIColor.darkGray;
		
        imageList = MXSTableView.init(frame: .zero, style: .plain)
        imageList?.register(cellName: "MXSImageNameCell", delegate: MXSFoundTDlg(), vc: self)
        view.addSubview(imageList!)
        imageList?.snp.makeConstraints({ (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0));
        })
        
        MXSSingletonCmd.shared.FileImageNams = MXSFileStorageCmd.shared.enumImagesFileName()
        imageList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams;
        
        imageList!.addPullToRefreshWithAction {
            MXSSingletonCmd.shared.FileImageNams = MXSFileStorageCmd.shared.enumImagesFileName()
            self.imageList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams;
            OperationQueue().addOperation {
                self.imageList!.reloadData()
                self.imageList!.stopPullToRefresh()
            }
        }
	}
    
    override func tableSelectedRowAt(_ indexPath: IndexPath) {
        let name = imageList?.dlg?.queryData![indexPath.row]
        MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSShowImgVC(), args: name as Any)
    }
    
    override func tableDeletedRowAt(_ indexPath: IndexPath) {
        let name = imageList?.dlg?.queryData![indexPath.row]
        MXSFileStorageCmd.shared.delImageWithName(name as! String)
        
        MXSSingletonCmd.shared.FileImageNams.remove(at: indexPath.row)
        imageList?.dlg?.queryData = MXSSingletonCmd.shared.FileImageNams
        imageList?.deleteRows(at: [indexPath], with: .left)
    }
}
