//
//  MXSContentCDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import Photos

class MXSContentCDlg: MXSCollectionDlg {
	
	var queryData_content: PHFetchResult<PHAsset>?
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		queryData_content?.enumerateObjects({ (asset, i, nil) in
			print("\(asset)")
		})
		return queryData_content?.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell:MXSContentItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName!, for: indexPath) as! MXSContentItemCell
		cell.cellData = queryData_content?[indexPath.row]
		return cell
	}
	
}
