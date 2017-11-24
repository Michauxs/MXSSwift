//
//  MXSProfileVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSProfileVC: MXSBaseVC {
	
	var userImageView : UIImageView?
	var coverViewHeight : CGFloat = 150
	
	override func viewDidLoad() {
		super.viewDidLoad();
		view.backgroundColor = UIColor.random;
		
		super.bindingTableView()
		
		userImageView = UIImageView.init(image: UIImage.init(named: "default_user"))
		userImageView?.contentMode = UIViewContentMode.scaleAspectFill
		userImageView?.clipsToBounds = true
		TableView?.addSubview(userImageView!)
		userImageView!.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.bottom.equalTo()(TableView?.mas_top)
			make.width.mas_equalTo()(SCREEN_WIDTH)
			make.centerX.equalTo()(TableView)
			make.height.mas_equalTo()(coverViewHeight)
		}
		
	}
	
	//MARK:layout
	override func TableLayout() {
		TableView!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.edges.equalTo()(view)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
		})
		TableView?.contentInset = UIEdgeInsetsMake(coverViewHeight, 0, 0, 0)
		TableView?.register(cellName: "MXSProfileCell", delegate: MXSProfileDlg(), vc: self, rowHeight:44)
		
		TableView?.dlg?.queryData = ["Model Exchange", "My Collection", "Person Setting", "About DongDa", "App Setting"]
	}
	
	override func tableDidScroll(offset_y: CGFloat) {
		let y = coverViewHeight + offset_y
		if y < 0 {
			userImageView!.mas_updateConstraints({ (make:MASConstraintMaker!) in
				make.height.mas_equalTo()(-offset_y)
			})
		} else {
			
		}
		
	}
}
