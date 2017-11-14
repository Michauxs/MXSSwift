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
			let nav_home = UINavigationController()
			nav_home.pushViewController(vc, animated: false)
			nav_arr.append(nav_home)
		}
		
		self.viewControllers = vc_arr
		
		let title_arr = ["HOME", "CONT", "FOUN", "SET"]
		for i in 0...title_arr.count-1 {
			let str = title_arr[i] as String
			setVCTabBarItem(vc: vc_arr[i], title: str, imageName: "tab_icon_"+String(i) as NSString)
		}
		
	}
	
	func setVCTabBarItem(vc:MXSBaseVC, title:String, imageName:NSString) {
		
		let attr_color_normal:Dictionary = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor:UIColor.darkGray]
		let attr_color_select:Dictionary = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor:UIColor.darkGray]
		
		let image = UIImage(named:imageName as String)?.withRenderingMode(.alwaysOriginal)
		let selectImage = UIImage(named:(imageName as String)+"_select")?.withRenderingMode(.alwaysOriginal)
		
//		vc.tabBarItem = UITabBarItem()
//		vc.tabBarItem.title = title
//		vc.tabBarItem.image = image
//		vc.tabBarItem.selectedImage = selectImage
		
		vc.tabBarItem = UITabBarItem.init(title: title, image: image, selectedImage: selectImage)
		vc.tabBarItem!.setTitleTextAttributes(attr_color_normal, for: UIControlState.normal)
		vc.tabBarItem!.setTitleTextAttributes(attr_color_select, for: UIControlState.selected)
	}
}
