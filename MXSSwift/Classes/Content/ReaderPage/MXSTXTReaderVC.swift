//
//  MXSTXTReaderVC.swift
//  MXSSwift
//
//  Created by Sunfei on 2018/6/6.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSTXTReaderVC: MXSBaseVC {

    var fileName : String?
    var textView : UITextView?
    
    override func receiveArgsBePost(args: Any) {
        fileName = args as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingNavBar()
        view.layer.contents = UIImage.init(named: "background")?.cgImage
        
        textView = UITextView.init()
        textView?.isEditable = false
        textView!.backgroundColor = UIColor.clear
        textView?.font = UIFont.systemFont(ofSize: 15)
        textView?.contentInset = UIEdgeInsets.init(top: 20, left: 15, bottom: 0, right: 15)
        view.addSubview(textView!)
        textView!.snp.makeConstraints { (mxs) in
            mxs.top.equalTo(view).offset(S_N_BAR_H)
            mxs.left.equalTo(view)
            mxs.right.equalToSuperview()
            mxs.bottom.equalToSuperview()
        }
        
        let content = MXSFileStorageCmd.shared.loadTextWithName(fileName!)
        textView?.text = content
        
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK:layout
    override func NavBarLayout() {
        super.NavBarLayout()
        NavBar?.titleLabel?.text = fileName
        NavBar?.titleLabel?.textColor = UIColor.black
        NavBar?.rightBtn?.isHidden = true
        NavBar?.setBackground(color: UIColor.lightBlack)
    }

    
    // MARK: - Navigation
    @objc func handleTapGesture (tap:UITapGestureRecognizer) {
        let tapPoint : CGPoint = tap.location(in: view)
        let p_x = tapPoint.x
        
        if p_x < SCREEN_WIDTH/3 {
            
        } else if p_x < SCREEN_WIDTH/3*2 {
//            MXSVCExchangeCmd.shared.SourseVCPop(sourse: self, args: fileName!)
            MXSVCExchangeCmd.shared.SourseVCPop(sourse: self, args: MXSNothing.shared)
            return
        } else {
            
        }
        
    }

}
