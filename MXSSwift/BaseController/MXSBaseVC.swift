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
	var CollectionView : MXSCollectionView?
	
	lazy var MXSBtmAlert : MXSBtmAlertView = {
		let alert_view = MXSBtmAlertView.init(vc:self)
		UIApplication.shared.keyWindow?.addSubview(alert_view)
		return alert_view
	}()
	
	lazy var loadingView : MXSProgressHUD = {
		let loading_view = MXSProgressHUD.init(UIApplication.shared.keyWindow!)
		return loading_view
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
	public func bindingCollectionView (layout:UICollectionViewFlowLayout) {
		CollectionView = MXSCollectionView.init(frame: .zero, collectionViewLayout: layout)
		view.addSubview(CollectionView!)
		CollectionViewLayout()
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
		NavBar!.snp.makeConstraints { (make) in
			make.left.equalTo(view)
			make.right.equalTo(view)
			make.top.equalTo(view).offset(STATUS_BAR_H)
			make.height.equalTo(NAV_BAR_H)
		}
	}
	public func TableLayout() {
		
	}
	public func CollectionViewLayout() {
		CollectionView?.backgroundColor = UIColor.clear
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
	
    @objc func tableDidDeletedRowWith (args : Any) {
        
    }
	public func tableDidScroll (offset_y:CGFloat) {
		
	}
	public func tableDidSelectedRowWith (args : Any) {
		
	}
	
	//MARK: collection notify
	public func collectionSelectedRowAt (_ indexPath:IndexPath) {
		
	}
	public func collectionDidScroll (offset_y:CGFloat) {
		
	}
	
	//MARK: btmAlert notify
	public func hideBtmAlertComplete (_ title:String = "Title") {
		MXSLog("no subclass respond method: hideBtmAlertComplete")
	}
	
	//MARK: application
	override var shouldAutorotate: Bool {
		return false
	}
	override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
		return .portrait
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait
	}
	
}
