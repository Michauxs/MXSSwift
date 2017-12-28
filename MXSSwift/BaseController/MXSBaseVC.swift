//
//  MXSBaseVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import SnapKit

class MXSBaseVC: UIViewController, MXSVCPtc {

	var NavBar : MXSNavBar?
	var TableView : MXSTableView?
	
	lazy var alertView : MXSBtmAlertView = {
		let alert_view = MXSBtmAlertView.init(vc:self)
		UIApplication.shared.keyWindow?.addSubview(alert_view)
//		 .addSubview(alert_view)
//		alert_view.showAlert()
		return alert_view
	}()
	
	public func receiveArgsBePost(args:Any) {
		MXSLog("no subclass received args be post")
	}
	public func receiveArgsBeBack(args:Any) {
		MXSLog("no subclass received args be back")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.lightBlack
		automaticallyAdjustsScrollViewInsets = false
    }

	//MARK:Actions
	public func bindingNavBar () {
		NavBar = MXSNavBar.init(vc: self)
		view.addSubview(NavBar!)
		NavBarLayout()
	}
	public func bindingTableView (style:UITableViewStyle = UITableViewStyle.plain) {
		TableView = MXSTableView.init(frame: .zero, style: style)
		view.addSubview(TableView!)
		TableLayout()
	}
	public func bindingCollectionView (layout:UICollectionViewFlowLayout) -> MXSCollectionView {
		let CollectionView = MXSCollectionView.init(frame: .zero, collectionViewLayout: layout)
		view.addSubview(CollectionView)
//		LayoutView(view: CollectionView)
		return CollectionView
	}
	public func bindingView () -> UIView {
		let view_dest = UIView.init()
		view.addSubview(view_dest)
		return view_dest
	}
	
	public func pickerSave () {
		MXSLog("no subclass fb: pickerSave()")
	}
	public func pickerCancel () {
		MXSLog("nothing todo, but must be revoked")
	}
	
	
	//MARK: layout
	public func NavBarLayout() {
		NavBar?.setBackground(color: UIColor.white)
	}
	public func TableLayout() {
		
	}
	public func LayoutView (view: UIView) {
		
	}
	
	//MARK: navbar notify
	public func didNavBarLeftClick () {
		MXSLog("no subclass respond method: didNavBarLeftClick")
		MXSVCExchangeCmd.shared.SourseVCPop(sourse: self, args: MXSNothing.shared)
	}
	public func didNavBarRightClick () {
		MXSLog("no subclass respond method: didNavBarRightClick")
	}
	
	//MARK: table notify
	public func tableSelectedRowAt (_ indexPath:IndexPath) {
		
	}
	public func tableDidScroll (offset_y:CGFloat) {
		
	}
	public func tableDeletedRowAt (_ indexPath:IndexPath) {
		
	}
	//MARK: navbar notify
	public func hideBtmAlertComplete (_ title:String = "Title") {
		MXSLog("no subclass respond method: hideBtmAlertComplete")
	}
}
