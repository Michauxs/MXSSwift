//
//  MXSVCExchangeCmd.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit
import SnapKit

class MXSVCExchangeCmd: NSObject {
	
	static let shared = MXSVCExchangeCmd()
	let keyView = UIApplication.shared.keyWindow
	let halfViewWidth:CGFloat = 243.5
	
	lazy var AnimateLeftView : UIImageView = {
		
		let left_view = UIImageView.init(image: UIImage.init(named: "trans_arrow_left"))
		left_view.tag = 999
		keyView!.addSubview(left_view)
		left_view.frame = CGRect.init(x: -halfViewWidth, y: 0, width: halfViewWidth, height: SCREEN_HEIGHT)
		return left_view
	}()
	lazy var AnimateRightView : UIImageView = {
		
		let right_view = UIImageView.init(image: UIImage.init(named: "trans_arrow_right"))
		right_view.tag = 999
		keyView!.addSubview(right_view)
		right_view.frame = CGRect.init(x: SCREEN_WIDTH, y: 0, width: halfViewWidth, height: SCREEN_HEIGHT)
		return right_view
	}()
	
	func SourseVCPushDestVC(sourse:MXSBaseVC, dest:MXSBaseVC, args:Any) {
		if !(args is MXSNothing) {
			dest.receiveArgsBePost(args: args)
		}
		
		AnimateRightView.isHidden = false
		AnimateLeftView.isHidden = false
		UIView.animate(withDuration: 0.35, animations: {
			self.AnimateLeftView.frame = CGRect.init(x: 0, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
			self.AnimateRightView.frame = CGRect.init(x: SCREEN_WIDTH-self.halfViewWidth, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
		}) { (complete) in
			
			dest.hidesBottomBarWhenPushed = true
			sourse.navigationController?.pushViewController(dest, animated: false)
			
			DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
				UIView.animate(withDuration: 0.35, animations: {
					self.AnimateLeftView.frame = CGRect.init(x: -self.halfViewWidth, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
					self.AnimateRightView.frame = CGRect.init(x: SCREEN_WIDTH, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
				}) {(complete) in
					self.AnimateRightView.isHidden = true
					self.AnimateLeftView.isHidden = true
				}
			})
		}
	}
	
	func SourseVCPop (sourse:MXSBaseVC, args:Any) {
		self.AnimateRightView.isHidden = false
		self.AnimateLeftView.isHidden = false
		UIView.animate(withDuration: 0.35, animations: {
			self.AnimateLeftView.frame = CGRect.init(x: 0, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
			self.AnimateRightView.frame = CGRect.init(x: SCREEN_WIDTH-self.halfViewWidth, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
		}) { (complete) in
			
			let nav = sourse.navigationController
			nav?.popViewController(animated: false)
			let pop = nav?.viewControllers.last as! MXSBaseVC
			if !(args is MXSNothing) {
				pop.receiveArgsBeBack(args:args)
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
				UIView.animate(withDuration: 0.35, animations: {
					self.AnimateLeftView.frame = CGRect.init(x: -self.halfViewWidth, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
					self.AnimateRightView.frame = CGRect.init(x: SCREEN_WIDTH, y: 0, width: self.halfViewWidth, height: SCREEN_HEIGHT)
				}) {(complete) in
					self.AnimateRightView.isHidden = true
					self.AnimateLeftView.isHidden = true
				}
			})
		}
		
	}
	
	func SourseVCPopToDest(sourse:MXSBaseVC, dest:MXSBaseVC, args:Any) {
		for vc in (sourse.navigationController?.viewControllers)! {
			if vc.isKind(of: object_getClass(dest)!) {
				
				sourse.navigationController?.popToViewController(vc, animated: true)
				if !(args is MXSNothing) {
					(vc as! MXSBaseVC).receiveArgsBeBack(args:args)
				}
			}
		}
	}
	func SourseVCPopToRoot(sourse:MXSBaseVC, args:Any) {
		sourse.navigationController?.popToRootViewController(animated: true)
		let pop = sourse.navigationController?.viewControllers.last as! MXSBaseVC
		if !(args is MXSNothing) {
			pop.receiveArgsBeBack(args:args)
		}
	}
	
	//MARK: module
	public func PresentVC(_ sourse:MXSBaseVC, dest:MXSBaseVC, args:Any) {
		if !(args is MXSNothing) {
			dest.receiveArgsBePost(args:args)
		}
		sourse.navigationController?.present(dest, animated: true, completion: {
			
		})
	}
	public func DismissVC (_ vc:MXSBaseVC, args:Any) {
		vc.dismiss(animated: true) {
			
		}
	}
	
	//		var count: UInt32 = 0
	//		let methods = class_copyMethodList(MXSTableView.self, &count)
	//
	//		for i in 0...count-1 {
	//			let method = methods![Int(i)]
	//			let sel = method_getName(method)
	//			let methodName = sel_getName(sel)
	//			let argument = method_getNumberOfArguments(method)
	//
	//			print("name: \(methodName), arguemtns: \(argument)")
	//		}
}
