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
		print("no subVC received args be post")
	}
	public func receiveArgsBeBack(args:Any) {
		print("no subVC received args be back")
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
	public func bindingTableView (style:UITableViewStyle = UITableViewStyle.grouped) {
		TableView = MXSTableView.init(frame: .zero, style: style)
		view.addSubview(TableView!)
		TableLayout()
	}
	
	//MARK: layout
	public func NavBarLayout() {
		NavBar?.setBackground(color: UIColor.white)
	}
	public func TableLayout() {
		TableView?.backgroundColor = UIColor.brown
	}
	
	//MARK: navbar notify
	public func didNavBarLeftClick () {
		print("BaseVC didNavBarLeftClick")
	}
	public func didNavBarRightClick () {
		print("BaseVC didNavBarRightClick")
	}
	
	public func tableSelectedRowAt (indexPath:IndexPath) {
		
	}
}
