//
//  MXSHomeCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 22/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSHomeCell: UITableViewCell {
	
	var thumImageView : UIImageView?
	var titleLabel : UILabel?
	var themeLabel : UILabel?
	var addrLabel : UILabel?
	var priceLabel : UILabel?
	var ageLabel : UILabel?
	var bookLabel : UILabel?
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.white
		selectionStyle = .none
		
		thumImageView = UIImageView.init(image: UIImage.init(named: "default_img"))
		thumImageView?.resizeScaleAspectFill()
		addSubview(thumImageView!)
		thumImageView!.mas_makeConstraints { (make:MASConstraintMaker!) in
			make.left.equalTo()(self)?.offset()(10)
			make.top.equalTo()(self)?.offset()(6)
			make.bottom.equalTo()(self)?.offset()(-6)
			make.width.mas_equalTo()(100)
		}
		
		titleLabel = UILabel.init(text: "服务标题", fontSize: 13, textColor: UIColor.black, alignment: .left)
		addSubview(titleLabel!)
		titleLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.left.equalTo()(thumImageView?.mas_right)?.offset()(15)
			make.top.equalTo()(thumImageView)
		})
		
		priceLabel = UILabel.init(text: "¥:88", fontSize: 13, textColor: UIColor.red, alignment: .left)
		addSubview(priceLabel!)
		priceLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.left.equalTo()(titleLabel)
			make.top.equalTo()(titleLabel?.mas_bottom)?.offset()(3)
		})

		themeLabel = UILabel.init(text: "服务主题", fontSize: 12, textColor: UIColor.black, alignment: .left)
		addSubview(themeLabel!)
		themeLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.left.equalTo()(priceLabel?.mas_right)?.offset()(15)
			make.bottom.equalTo()(priceLabel)
		})

		ageLabel = UILabel.init(text: "年龄：2-8", fontSize: 12, textColor: UIColor.orange, alignment: .left)
		ageLabel?.setRadius(radius: 2, borderColor: UIColor.orange, borderWidth: 0.5)
		addSubview(ageLabel!)
		ageLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.left.equalTo()(titleLabel)
			make.top.equalTo()(priceLabel?.mas_bottom)?.offset()(8)
		})

		bookLabel = UILabel.init(text: "已预订：6/8", fontSize: 12, textColor: UIColor.brown, alignment: .left)
		bookLabel?.setRadius(radius: 2, borderColor: UIColor.brown, borderWidth: 0.5)
		addSubview(bookLabel!)
		bookLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.left.equalTo()(ageLabel?.mas_right)?.offset()(15)
			make.centerY.equalTo()(ageLabel)
		})
		
		addrLabel = UILabel.init(text: "地址:Service address info", fontSize: 12, textColor: UIColor.random, alignment: .left)
		addSubview(addrLabel!)
		addrLabel!.mas_makeConstraints({ (make:MASConstraintMaker!) in
			make.left.equalTo()(titleLabel)
			make.top.equalTo()(ageLabel?.mas_bottom)?.offset()(8)
		})

	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:acions
	public func setCellData(data:Any) {
		let cell_info:Dictionary<String,Any> = data as! Dictionary<String,Any>
		titleLabel?.text = cell_info["title"] as? String
		
	}
}
