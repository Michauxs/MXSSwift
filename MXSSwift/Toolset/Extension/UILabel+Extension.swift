//
//  UILabel+Extension.swift
//  MXSSwift
//
//  Created by Alfred Yang on 16/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	
	public convenience init(text:String, fontSize:CGFloat, textColor:UIColor, alignment:NSTextAlignment) {
		self.init()
		self.text = text
		self.font = UIFont.systemFont(ofSize: fontSize)
		self.textColor = textColor
		self.textAlignment = alignment
        self.numberOfLines = 0
	}
    
    static public func makeLabelWith(text:String, font:CGFloat, textColor:UIColor, alignment:NSTextAlignment) -> UILabel {
        let label = UILabel.init()
        label.text = text
        label.font = UIFont.systemFont(ofSize: font)
        label.textColor = textColor
        label.textAlignment = alignment
        label.numberOfLines = 0
        return label
    }
}
