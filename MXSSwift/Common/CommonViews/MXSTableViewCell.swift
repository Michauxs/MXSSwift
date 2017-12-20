//
//  MXSTableViewCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 24/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSTableViewCell: UITableViewCell {

	var cellData : Any? {
		didSet {
			
		}
	}
    
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.white
		selectionStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
