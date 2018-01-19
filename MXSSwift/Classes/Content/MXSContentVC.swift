//
//  MXSContentVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import AssetsLibrary
import SnapKit

class MXSContentVC: MXSBaseVC {
	
	var collectionView : MXSCollectionView?
	var menuArr : Array<String>?
	
	override func viewDidLoad() {
		super.viewDidLoad();
		
		bindingNavBar()
		bindingTableView()
		
		let menuData = MXSMenu.fetchDish()
		menuArr = Array.init()
		for dish in menuData {
			menuArr?.append(dish.name!)
		}
		TableView?.dlg?.queryData = menuArr
		
		let btn = UIButton.init(text: "Random", fontSize: 16, textColor: UIColor.orange, background: UIColor.white)
		view .addSubview(btn)
		btn.snp.makeConstraints { (make) in
			make.right.equalTo(view).offset(-30)
			make.bottom.equalTo(view).offset(-30-TAB_BAR_H)
			make.size.equalTo(CGSize.init(width: 60, height: 40))
		}
		btn.addTarget(self, action: #selector(randomClick), for: .touchUpInside)
	}
	
	//MARK: layout
	override func NavBarLayout() {
		super.NavBarLayout()
		NavBar?.titleLabel?.text = "Let It Go"
		NavBar?.rightBtn?.setTitle("Add", for: .normal)
		NavBar?.leftBtn?.isHidden = true
	}
	
	override func TableLayout() {
		super.TableLayout()
		TableView!.snp.makeConstraints { (make) in
			make.edges.equalTo(view).inset(UIEdgeInsets.init(top: S_N_BAR_H, left: 0, bottom: 0, right: 0))
		}
		TableView?.register(cellName: "MXSContentCell", delegate: MXSContentTDlg(), vc: self)
		TableView?.addPullToRefreshWithAction {
			OperationQueue().addOperation {
				self.loadNewData()
			}
		}
	}
	//MARK:acions
	@objc func loadNewData() {
		
		TableView?.dlg?.queryData = menuArr
		
		OperationQueue.main.addOperation {
			self.TableView?.reloadData()
			self.TableView?.stopPullToRefresh()
		}
	}

	@objc func randomClick() {
		let alert = UIAlertController.init(title: "Random", message: "please input progress Count", preferredStyle: .alert)
		alert.addTextField { (textFiled) in
			textFiled.keyboardType = .numberPad
		}
		
		alert.addAction(UIAlertAction.init(title: "Certain", style: .default, handler: { (action) in
			let textfield = alert.textFields?.first
			
			var result = Array<String>.init()
			for _ in 1...Int((textfield?.text!)!)! {
				let sum = self.menuArr?.count
				let index_random = arc4random() % UInt32(sum!)
				result.append(self.menuArr![Int(index_random)])
			}
			
			self.TableView?.dlg?.queryData = result
			self.TableView?.reloadData()
			
			//save coredata
			MXSMenu.addDish(self.menuArr!)
		}))
		alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
			
		}))
		
		present(alert, animated: true, completion: nil)
	}
	
	//MARK:notifies
	override func didNavBarRightClick() {
		let alert = UIAlertController.init(title: "Add Option", message: "options", preferredStyle: .alert)
		
		alert.addTextField { (textFiled) in
//			textFiled.keyboardType = .numberPad
		}
		
		alert.addAction(UIAlertAction.init(title: "Certain", style: .default, handler: { (action) in
			let textfield = alert.textFields?.first
			
			self.menuArr?.append((textfield?.text)!)
			self.TableView?.dlg?.queryData = self.menuArr
			self.TableView?.reloadData()
		}))
		alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
			
		}))
		
		present(alert, animated: true, completion: nil)
		
	}
	
	override func tableDeletedRowAt(_ indexPath: IndexPath) {
		let name = menuArr![indexPath.row]
		MXSMenu.removeDish(name)
		
		menuArr?.remove(at: indexPath.row)
		TableView?.dlg?.queryData = menuArr
		TableView?.deleteRows(at: [indexPath], with: .left)
	}
}
