//
//  MXSProfileCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 24/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSProfileCell: MXSTableViewCell {

	var titleLabel : UILabel?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		titleLabel = UILabel.init(text: "User info", fontSize: 14, textColor: UIColor.white, alignment: .left)
		addSubview(titleLabel!)
		titleLabel!.snp.makeConstraints { (make) in
			make.centerY.equalTo(self)
			make.left.equalTo(self).offset(15)
		}
		
		drawBtmLine()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	 override var cellData: Any? {
		willSet{
			
		}
		didSet{
			
			titleLabel?.text = cellData as? String
		}
	}
	
}
