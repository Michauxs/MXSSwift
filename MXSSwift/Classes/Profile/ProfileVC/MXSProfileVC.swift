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
	
	override func receiveArgsBeBack(args: Any) {
		if args is UIImage {
			userImageView?.image = args as? UIImage
			
			let dir = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
			let path = (dir! as NSString).appendingPathComponent("Preferences/mxs_profile_cover_img.png")
			let url = NSURL.init(fileURLWithPath: path)
			
			do {
				try UIImageJPEGRepresentation(args as! UIImage, 0.5)?.write(to: url as URL, options: .atomicWrite)
//				UIImageJPEGRepresentation(args as! UIImage, 0.5).w
			} catch {
				fatalError("不能保存：\(error)")
			}
			
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad();
		
		super.bindingTableView()
		
		userImageView = UIImageView.init(image: UIImage.init(named: "default_img"))
		
		let dir = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
		let path = (dir! as NSString).appendingPathComponent("Preferences/mxs_profile_cover_img.png")
		let cover_img = UIImage.init(contentsOfFile: path)
		if (cover_img != nil) {
			userImageView?.image = cover_img
		}
		
		userImageView?.contentMode = UIViewContentMode.scaleAspectFill
		userImageView?.clipsToBounds = true
		TableView?.addSubview(userImageView!)
		userImageView!.snp.makeConstraints { (make) in
			make.bottom.equalTo(TableView!.snp.bottom)
			make.width.equalTo(SCREEN_WIDTH)
			make.centerX.equalTo(TableView!)
			make.height.equalTo(coverViewHeight)
		}
		
		userImageView?.isUserInteractionEnabled = true
		userImageView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(coverTap)))
	}
	
	//MARK:layout
	override func TableLayout() {
		TableView!.snp.makeConstraints { (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
		}
		TableView?.contentInset = UIEdgeInsetsMake(coverViewHeight, 0, 0, 0)
		TableView?.register(cellName: "MXSProfileCell", delegate: MXSProfileDlg(), vc: self)
		
		TableView?.dlg?.queryData = ["My Diray", "Edit Diary",  "Xcode Complete","About DongDa -TODO", "App Setting -TODO"]
	}
	
	//MARK:actions
	@objc func coverTap () {
		alertView.titleLabel?.text = "To pick image for the view of cover"
		alertView.showAlert()
	}
	
	//MARK:notifies
	override func hideBtmAlertComplete(_ title: String) {
		MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSPickImgVC(), args: MXSNothing.shared)
	}
	
	override func tableSelectedRowAt(_ indexPath: IndexPath) {
		if indexPath.row == 0 {
			MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSDiaryVC(), args: MXSNothing.shared)
		} else if indexPath.row == 1 {
			MXSVCExchangeCmd.shared .SourseVCPushDestVC(sourse: self, dest: MXSShowDiaryVC(), args: MXSNothing.shared)
		} else if indexPath.row == 2 {
			MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSXcodePSVC(), args: MXSNothing.shared)
			
		} else if indexPath.row == 3 {
			
		} else if indexPath.row == 4 {
			
		}
	}
	
	override func tableDidScroll(offset_y: CGFloat) {
		let y = coverViewHeight + offset_y
		if y < 0 {
			userImageView!.snp.updateConstraints({ (make) in
				make.height.equalTo(-offset_y)
			})
		} else {
			
		}
		
	}
}
