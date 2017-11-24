//
//  MXSBaseVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSBaseVC: UIViewController, MXSVCPtc {

	var NavBar : MXSNavBar?
	var TableView : MXSTableView?
	
	public func receiveArgsBePost(args:Any) {
		MXSLog("no subclass received args be post")
	}
	public func receiveArgsBeBack(args:Any) {
		MXSLog("no subclass received args be back")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.init(white: 0.3, alpha: 1)
		automaticallyAdjustsScrollViewInsets = false
    }

	public func bindingNavBar () {
		NavBar = MXSNavBar.init(vc: self)
		view.addSubview(NavBar!)
		NavBarLayout()
	}
	public func bindingTableView (style:UITableViewStyle = UITableViewStyle.plain) {
		TableView = MXSTableView.init(frame: .zero, style: style)
		view.addSubview(TableView!)
		TableView?.backgroundColor = UIColor.white
		TableView?.separatorStyle = .none
		TableLayout()
	}
	
	//MARK: layout
	public func NavBarLayout() {
		NavBar?.setBackground(color: UIColor.white)
	}
	public func TableLayout() {
		
	}
	
	//MARK: navbar notify
	public func didNavBarLeftClick () {
		MXSLog("no subclass respond method: didNavBarLeftClick")
	}
	public func didNavBarRightClick () {
		MXSLog("no subclass respond method: didNavBarRightClick")
	}
	
	//MARK: table notify
	public func tableSelectedRowAt (indexPath:IndexPath) {
		
	}
	public func tableDidScroll (offset_y:CGFloat) {
		
	}
}
