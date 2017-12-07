//
//  MXSXcodeTableHeadView.swift
//  MXSSwift
//
//  Created by Alfred Yang on 7/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSXcodeTableHeadView: UITableViewHeaderFooterView {

	var label : UILabel?
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		upsetLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func upsetLayout () {
		backgroundColor = UIColor.white
		label = UILabel.init(text: "Head", fontSize: 13, textColor: .black, alignment: .left)
		addSubview(label!)
		label!.snp.makeConstraints { (make) in
			make.left.equalTo(self).offset(15)
			make.centerY.equalTo(self)
		}
	}
	
}
