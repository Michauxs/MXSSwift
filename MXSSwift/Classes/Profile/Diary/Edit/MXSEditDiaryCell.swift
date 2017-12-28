//
//  MXSEditDiaryCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSEditDiaryCell: MXSTableViewCell {

	var titleLabel : UILabel?
	var contentLabel : UILabel?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		titleLabel = UILabel.init(text: "Title", fontSize: 13, textColor: UIColor.dullWhite, alignment: .left)
		titleLabel?.numberOfLines = 3
		addSubview(titleLabel!)
		titleLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(self).offset(15)
			make.top.equalTo(self).offset(10)
			make.width.equalTo(60)
		})
		
		
		contentLabel = UILabel.init(text: "略", fontSize: 12, textColor: UIColor.gray, alignment: .left)
		contentLabel?.numberOfLines = 3
		addSubview(contentLabel!)
		contentLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(titleLabel!.snp.right).offset(20)
			make.top.equalTo(titleLabel!)
//			make.right.equalTo(self).offset(-15)
			make.right.lessThanOrEqualTo(self).offset(-15)
			make.bottom.equalTo(self).offset(-10)
		})
		
		
		drawBtmLine()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:acions
	override var cellData: Any? {
		didSet {
//			titleLabel?.text = (cellData as! MXSDiary).uuid
			contentLabel?.text = (cellData as! String)
		}
	}

}
