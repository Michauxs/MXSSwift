//
//  MXSCollectionDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 27/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSCollectionDlg: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
	
	var queryData : Any?
	var itemSize : CGSize?
	var cellName : String?
	var controller : MXSBaseVC?
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mxs", for: indexPath)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return itemSize!
	}
	
	
	//MARK:scrollview
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset_y = scrollView.contentOffset.y
		controller?.tableDidScroll(offset_y: offset_y)
	}
	
}
