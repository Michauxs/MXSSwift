//
//  MXSXcodePSCell.swift
//  MXSSwift
//
//  Created by Alfred Yang on 6/12/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import SnapKit

class MXSXcodePSCell: MXSTableViewCell {
    
    var nameLabel : UILabel?
    var descLabel : UILabel?
    var urlLabel : UILabel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel.init(text: "Title", fontSize: 13, textColor: .dullWhite, alignment: .left)
        addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(15)
        })
        
        urlLabel = UILabel.init(text: "URL", fontSize: 12, textColor: .theme, alignment: .left)
        addSubview(urlLabel!)
        urlLabel?.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(nameLabel!.snp.bottom).offset(3)
            make.left.equalTo(nameLabel!)
            make.right.equalTo(self).offset(-15)
        })
        
        descLabel = UILabel.init(text: "Desc", fontSize: 12, textColor: .gray, alignment: .left)
        addSubview(descLabel!)
        descLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(urlLabel!.snp.bottom).offset(3)
            make.left.equalTo(nameLabel!)
            make.right.equalTo(self).offset(-15)
			make.bottom.equalTo(self).offset(-15)
        })
        
        
//        backgroundColor = UIColor.white
//        selectionStyle = .none
//
//        let btmLine = UIView.init()
//        btmLine.backgroundColor = UIColor.grayline
//        addSubview(btmLine)
//        btmLine.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.bottom.equalTo()(self)
//            make.left.equalTo()(self)
//            make.right.equalTo()(self)
//            make.height.mas_equalTo()(0.5)
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
    override var cellData: Any? {
        didSet {
            guard cellData != nil else {
                return
            }
            nameLabel?.text = (cellData as! Dictionary<String,Any>)["Dname"] as? String
            urlLabel?.text = (cellData as! Dictionary<String,Any>)["Durl"] as? String
            descLabel?.text = (cellData as! Dictionary<String,Any>)["Dtext"] as? String
        }
    }
}
