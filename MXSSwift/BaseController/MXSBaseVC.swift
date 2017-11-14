//
//  MXSBaseVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 14/11/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class MXSBaseVC: UIViewController, MXSVCPtc {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.init(white: 0.3, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
