//
//  MXSContCell.swift
//  MXSSwift
//
//  Created by Sunfei on 2018/6/6.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSContCell: MXSTableViewCell {

    var nameLabel : UILabel?
    var signLabel : UILabel?
    
    override func setupUI() {
        nameLabel = UILabel.makeLabelWith(text: "Name", font: 14, textColor: .dullWhite, alignment: .left)
        addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        })
        
    }
    
    override var cellData: Any? {
        didSet {
//            NSAttributedStringKey.font
            nameLabel?.text = cellData as? String
        }
    }

}
