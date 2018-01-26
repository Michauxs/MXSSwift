//
//  MXSWebSitesCDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 26/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSWebSitesCDlg: MXSCollectionDlg {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return queryData?.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let listData:Dictionary<String,Any> = queryData?[section] as! Dictionary
		let list = listData["list"] as! Array<Dictionary<String,Any>>
		return list.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MXSWebSitesCell", for: indexPath) as! MXSWebSitesCell
		let listData:Dictionary<String,Any> = queryData?[indexPath.section] as! Dictionary
		let list = listData["list"] as! Array<Dictionary<String,Any>>
		cell.cellData = list[indexPath.row]
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize.init(width: (SCREEN_WIDTH-20*4-6)/3, height: 30)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize.init(width: SCREEN_WIDTH-20*2, height: 10)
	}
	
	
}
