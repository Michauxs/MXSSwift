//
//  MXSTabBarController.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let vc_arr = [MXSHomeVC(), MXSContentVC(), MXSFoundVC(), MXSProfileVC()]
		var nav_arr = Array<UINavigationController>()
		
		for vc in vc_arr {
			let nav_c = MXSNavigationVC.init()
			nav_c.pushViewController(vc, animated: false)
			nav_c.setNavigationBarHidden(true, animated: false)
			nav_arr.append(nav_c)
		}
		
		self.viewControllers = nav_arr
		
		let title_arr = ["HOME", "CONT", "FOUN", "SET"]
		for i in 0...nav_arr.count-1 {
			let str = title_arr[i] as String
			setVCTabBarItem(vc: vc_arr[i], title: str, imageName: "tab_icon_" + String(i))
		}
		
		tabBar.barTintColor = UIColor.lightBlack
		tabBar.isTranslucent = false
		
		selectedIndex = 2
	}
	
	func setVCTabBarItem(vc:MXSBaseVC, title:String, imageName:String) {
		
		let image = UIImage(named:imageName as String)?.withRenderingMode(.alwaysOriginal)
		let selectImage = UIImage(named:(imageName as String)+"_select")?.withRenderingMode(.alwaysOriginal)
		
		let attr_color_normal:Dictionary = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor:UIColor.darkGray]
		let attr_color_select:Dictionary = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor:UIColor.theme]
		
		vc.tabBarItem = UITabBarItem.init(title: title, image: image, selectedImage: selectImage)
		vc.tabBarItem!.setTitleTextAttributes(attr_color_normal, for: UIControlState.normal)
		vc.tabBarItem!.setTitleTextAttributes(attr_color_select, for: UIControlState.selected)
	}
	
	//MARK: application
	override var shouldAutorotate: Bool {
		return false
	}
	
	override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
		return .portrait
		//		return .portraitUpsideDown
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait
	}
}
