//
//  MXSDiaryCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSDiaryCell: MXSTableViewCell {
	
	var weatherLabel : UILabel?
	var dateLabel : UILabel?
	
	var gradingView : UIImageView?
	
	var contentLabel : UILabel?
	var thinkLabel : UILabel?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		dateLabel = UILabel.init(text: "2017-12-12 EEEE", fontSize: 13, textColor: UIColor.black, alignment: .left)
		addSubview(dateLabel!)
		dateLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(self).offset(15)
			make.top.equalTo(self).offset(6)
		})
		
		weatherLabel = UILabel.init(text: "Sunny", fontSize: 13, textColor: UIColor.gray, alignment: .left)
		addSubview(weatherLabel!)
		weatherLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!.snp.right).offset(15)
			make.centerY.equalTo(dateLabel!)
		})
		
//		gradingView = UIImageView.init(image: UIImage.init(named: "star_rang_5"))
//		addSubview(gradingView!)
//		gradingView!.snp.makeConstraints { (make) in
//			make.left.equalTo(dateLabel!)
//			make.top.equalTo(dateLabel!.snp.bottom).offset(5)
//			make.size.equalTo(CGSize.init(width: 96, height: 15))
//		}
		
		let contentTitle = UILabel.init(text: "EXP：", fontSize: 13, textColor: UIColor.black, alignment: .left)
		addSubview(contentTitle)
		contentTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(self).offset(15)
			make.top.equalTo(weatherLabel!.snp.bottom).offset(15)
		})
		
		contentLabel = UILabel.init(text: "Richangjingli", fontSize: 12, textColor: UIColor.gray, alignment: .left)
		contentLabel?.numberOfLines = 2
		addSubview(contentLabel!)
		contentLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(self).offset(65)
			make.top.equalTo(contentTitle)
			make.right.lessThanOrEqualTo(self).offset(-15)
		})
		
		let thinkTitle = UILabel.init(text: "FEEL：", fontSize: 13, textColor: UIColor.black, alignment: .left)
		addSubview(thinkTitle)
		thinkTitle.snp.makeConstraints({ (make) in
			make.left.equalTo(self).offset(15)
			make.top.equalTo(contentLabel!.snp.bottom).offset(10)
		})
		
		thinkLabel = UILabel.init(text: "Xinlicexie", fontSize: 12, textColor: UIColor.gray, alignment: .left)
		thinkLabel?.numberOfLines = 2
//		thinkLabel?.setRadius(radius: 2, borderColor: UIColor.theme, borderWidth: 0.5)
		addSubview(thinkLabel!)
		thinkLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(self).offset(65)
			make.top.equalTo(thinkTitle)
			make.right.lessThanOrEqualTo(self).offset(-15)
			make.bottom.equalTo(self).offset(-15)
		})
		
		drawBtmLine()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:acions
	override var cellData: Any? {
		didSet {
			dateLabel?.text = MXSToolsCmd.shared.dateConvertString((cellData as! MXSDiary).date_daily! as Date, defFormat: "yyyy-MM-dd EEE")
			weatherLabel?.text = MXSToolsCmd.shared.transWeather(Int((cellData as! MXSDiary).weather))
			contentLabel?.text = (cellData as! MXSDiary).diary_content
			thinkLabel?.text = (cellData as! MXSDiary).diary_think
			
			let line = UIView.init()
			line.backgroundColor = UIColor.grayline
			addSubview(line)
			line.snp.remakeConstraints { (make) in
				make.left.equalTo(dateLabel!)
				make.top.equalTo(dateLabel!.snp.bottom).offset(5)
				make.right.equalTo(weatherLabel!)
				make.height.equalTo(0.5)
			}
		}
	}

}
