//
//  ViewController.swift
//  MXSSwift
//
//  Created by Alfred Yang on 24/10/17.
//  Copyright © 2017年 MXS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var tableView:UITableView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.red
		
		tableView = UITableView();
		tableView?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
		
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

