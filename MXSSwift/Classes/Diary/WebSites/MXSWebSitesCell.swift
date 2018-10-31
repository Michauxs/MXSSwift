//
//  MXSWebSitesCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 26/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSWebSitesCell: MXSCollectionViewCell {
	
	var titleLabel : UILabel?
	var urlStr : String?
	
	override init(frame: CGRect) {
		super.init(frame : frame)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setupUI() {
		titleLabel = UILabel.init(text: "Web", fontSize: 13, textColor: .dullWhite, alignment: .center)
		setRadius(radius: 5, borderColor: UIColor.dullLine as Any, borderWidth: 1, backgropund: MXSNothing.shared)
		addSubview(titleLabel!)
		titleLabel?.snp.makeConstraints({ (make) in
			make.center.equalTo(self)
		})
	}
	
	override var cellData: Any? {
		didSet {
			let cell_info:Dictionary<String,Any> = cellData as! Dictionary<String,Any>
			titleLabel?.text = cell_info["site"] as? String
			urlStr = cell_info["href"] as? String
		}
	}
}
