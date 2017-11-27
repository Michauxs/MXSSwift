//
//  MXSContentVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSContentVC: MXSBaseVC {
	
	var collectionView : MXSCollectionView?
	
	override func viewDidLoad() {
		super.viewDidLoad();
		self.view.backgroundColor = UIColor.theme;
		
//		var count: UInt32 = 0
//		let methods = class_copyMethodList(MXSTableView.self, &count)
//
//		for i in 0...count-1 {
//			let method = methods![Int(i)]
//			let sel = method_getName(method)
//			let methodName = sel_getName(sel)
//			let argument = method_getNumberOfArguments(method)
//
//			print("name: \(methodName), arguemtns: \(argument)")
//		}
		
		let layout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = UICollectionViewScrollDirection.horizontal
		layout.minimumLineSpacing = 5
		layout.minimumInteritemSpacing = 5
		
		collectionView = MXSCollectionView.init(frame: .zero, collectionViewLayout: layout)
		view.addSubview(collectionView!)
		collectionView!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.top.equalTo()(view)
			make.left.equalTo()(view)
			make.right.equalTo()(view)
			make.height.mas_equalTo()(250)
		})
	}
}
