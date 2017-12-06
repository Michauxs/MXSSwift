//
//  MXSTableViewCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 24/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSTableViewCell: UITableViewCell {

    var cellData : Any?
    
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.white
		selectionStyle = .none
		
		let btmLine = UIView.init()
		btmLine.backgroundColor = UIColor.grayline
		addSubview(btmLine)
		btmLine.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.bottom.equalTo()(self)
			make.left.equalTo()(self)
			make.right.equalTo()(self)
			make.height.mas_equalTo()(0.5)
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
