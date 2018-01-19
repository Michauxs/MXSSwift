//
//  MXSNavigationVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 19/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: application
	override var shouldAutorotate: Bool {
		return false
	}
	
	override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
		return .portrait
//		return .portraitUpsideDown
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait
	}
}
