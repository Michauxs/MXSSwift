//
//  MXSDiaryCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 20/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSDiaryCell: MXSTableViewCell {

	var thumImageView : UIImageView?
	var weatherLabel : UILabel?
	var dateLabel : UILabel?
	
	var gradingView : UIImageView?
	
	var contentLabel : UILabel?
	var thinkLabel : UILabel?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
//		thumImageView = UIImageView.init(image: UIImage.init(named: "default_img"))
//		thumImageView?.resizeScaleAspectFill()
//		addSubview(thumImageView!)
//		thumImageView?.snp.makeConstraints({ (make) in
//			make.left.equalTo(self).offset(10)
//			make.top.equalTo(self).offset(6)
//			make.bottom.equalTo(self).offset(-6)
//			make.width.equalTo(SCREEN_WIDTH*0.5 - 10)
//		})
		
		dateLabel = UILabel.init(text: "2017-12-12 EEEE", fontSize: 13, textColor: UIColor.red, alignment: .left)
		addSubview(dateLabel!)
		dateLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(self).offset(15)
			make.top.equalTo(self).offset(6)
		})
		
		weatherLabel = UILabel.init(text: "Sunny", fontSize: 13, textColor: UIColor.black, alignment: .left)
		addSubview(weatherLabel!)
		weatherLabel?.snp.makeConstraints({ (make) in
			make.right.equalTo(self).offset(-15)
			make.centerY.equalTo(dateLabel!)
		})
		
		gradingView = UIImageView.init(image: UIImage.init(named: "star_rang_5"))
		addSubview(gradingView!)
		gradingView!.snp.makeConstraints { (make) in
			make.left.equalTo(dateLabel!)
			make.top.equalTo(dateLabel!.snp.bottom).offset(5)
			make.size.equalTo(CGSize.init(width: 96, height: 15))
		}
		
		contentLabel = UILabel.init(text: "Richangjingli", fontSize: 12, textColor: UIColor.orange, alignment: .left)
		contentLabel?.numberOfLines = 3
		contentLabel?.setRadius(radius: 2, borderColor: UIColor.orange, borderWidth: 0.5)
		addSubview(contentLabel!)
		contentLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.top.equalTo(gradingView!.snp.bottom).offset(8)
		})
		
		thinkLabel = UILabel.init(text: "Xinlicexie", fontSize: 12, textColor: UIColor.brown, alignment: .left)
		thinkLabel?.numberOfLines = 3
		thinkLabel?.setRadius(radius: 2, borderColor: UIColor.brown, borderWidth: 0.5)
		addSubview(thinkLabel!)
		thinkLabel?.snp.makeConstraints({ (make) in
			make.left.equalTo(dateLabel!)
			make.top.equalTo(contentLabel!.snp.bottom).offset(5)
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
			dateLabel?.text = (cellData as! MXSDiary).uuid
//			weatherLabel?.text = WeatherState(rawValue:10) as String
			contentLabel?.text = (cellData as! MXSDiary).diary_content
			thinkLabel?.text = (cellData as! MXSDiary).diary_think
		}
	}

}
