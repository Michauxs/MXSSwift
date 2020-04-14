//
//  MXSContVC.swift
//  MXSSwift
//
//  Created by Sunfei on 2018/6/6.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSContVC: MXSBaseVC {

    var txtNameTable : MXSTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray;

        txtNameTable = MXSTableView.init(frame: .zero, style: .plain)
        txtNameTable?.register(cellNames: ["MXSContCell"], delegate: MXSContTDlg(), vc: self)
        view.addSubview(txtNameTable!)
        txtNameTable?.snp.makeConstraints({ (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0));
        })
        
        txtNameTable?.dlg?.queryData =  MXSFileStorageCmd.shared.enumTextFileName()
        txtNameTable?.mj_header = MJRefreshStateHeader.init(refreshingBlock: {
            self.txtNameTable?.dlg?.queryData = MXSFileStorageCmd.shared.enumTextFileName()
            DispatchQueue.main.async {
                self.txtNameTable!.reloadData()
                self.txtNameTable?.mj_header.endRefreshing()
            }
        })
//        txtNameTable!.header = JRefreshStateHeader.headerWithRefreshingBlock({[weak self] in
//
//            self?.txtNameTable?.dlg?.queryData = MXSFileStorageCmd.shared.enumTextFileName()
//            DispatchQueue.main.async {
//                self?.txtNameTable!.reloadData()
//                self?.txtNameTable!.header?.endRefreshing()
//            }
//        })

//        txtNameTable?.isHidden = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        view.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePinchGesture (pinch:UIPinchGestureRecognizer) {
        let factor = pinch.scale
        if factor > 3 {
            txtNameTable?.isHidden = false
        } else if factor < 0.3 {
            txtNameTable?.isHidden = true
        }
    }
    
    
    @objc override func tableDidSelectedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let name = txtNameTable?.dlg?.queryData![indexPath.row]
        MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSTXTReaderVC(), args: name as Any)
    }
    

    
    @objc override func tableDidDeletedRowWith (args : Any) {
        
        let indexPath : IndexPath = (args as! Dictionary<String,Any>)["indexPath"] as! IndexPath
        let name = txtNameTable?.dlg?.queryData![indexPath.row]
        MXSFileStorageCmd.shared.delTextWithName(name as! String)
        
        txtNameTable?.dlg?.queryData?.remove(at: indexPath.row)
        txtNameTable?.deleteRows(at: [indexPath], with: .left)
    }
}
