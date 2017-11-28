//
//  MXSContentCDlg.swift
//  MXSSwift
//
//  Created by Alfred Yang on 28/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSContentCDlg: MXSCollectionDlg {
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell:MXSContentItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName!, for: indexPath) as! MXSContentItemCell
		
		return cell
	}
}
