//
//  MXSWebSitesVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 26/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSWebSitesVC: MXSBaseVC {

	var psData : Array<Any>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bindingNavBar()
		
		let layout = MXSCollectionViewLeftAlignLayout.init(.left, 20)
		layout.minimumLineSpacing = 20
		layout.scrollDirection = .vertical
		bindingCollectionView(layout: layout)
		
		let path = Bundle.main.path(forResource: "website_complete", ofType: "json")
		let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path!))
		MXSLog(data as Any)
		do {
			let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
			psData = json as? Array
			CollectionView?.dlg?.queryData = psData
		} catch {
			MXSLog("error: data->object")
		}
		
	}
	
	//MARK:Layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.titleLabel?.text = "WebSite Complete"
		NavBar?.rightBtn?.isHidden = true
	}

	override func CollectionViewLayout() {
		super.CollectionViewLayout()
		CollectionView?.register(cellName: "MXSWebSitesCell", delegate: MXSWebSitesCDlg(), vc: self)
		CollectionView?.snp.makeConstraints({ (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 20, bottom: 0, right: 20))
		})
//		CollectionView.der
	}
	
	
	//MARK: - notifies
	override func collectionSelectedRowAt(_ indexPath: IndexPath) {
		let listData:Dictionary<String,Any> = psData?[indexPath.section] as! Dictionary
		let list = listData["list"] as! Array<Dictionary<String,Any>>
		let data = list[indexPath.row] as Dictionary<String,Any>
		
		let href = data["href"]
		MXSVCExchangeCmd.shared.SourseVCPushDestVC(sourse: self, dest: MXSWebBrowseVC(), args: href as Any)
	}
}
