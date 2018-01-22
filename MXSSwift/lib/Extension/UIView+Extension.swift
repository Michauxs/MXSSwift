//
//  UIView+Extension.swift
//  MXSSwift
//
//  Created by Alfred Yang on 23/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	public func setRadius(radius:CGFloat, borderColor:Any, borderWidth:CGFloat, backgropund:Any) {
		layer.cornerRadius = radius
		if !(borderColor is MXSNothing) {
			layer.borderColor = (borderColor as! UIColor).cgColor
		}
		if !(backgropund is MXSNothing) {
			self.backgroundColor = backgropund as? UIColor
		}
		layer.borderWidth = borderWidth
		clipsToBounds = true
	}
	
	public func resizeScaleAspectFill() {
		
		contentMode = UIViewContentMode.scaleAspectFill
		clipsToBounds = true
	}
	
//	public func addTapGestrue (vc:MXSBaseVC) {	//Method cannot be declared public because its parameter uses an internal type
//		isUserInteractionEnabled = true
//
//	}
}
