//
//  MXSAVPlayVC.swift
//  MXSSwift
//
//  Created by Alfred Yang on 11/1/18.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit
import AVFoundation

class MXSAVPlayVC: MXSBaseVC {

	var videoName : String?
	
	override func receiveArgsBePost(args: Any) {
		videoName = args as? String
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		super.bindingNavBar()
		
		let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let videoURL = NSURL.init(fileURLWithPath: docuDir.first!+"/"+videoName!)
		
		let avItem = AVPlayerItem.init(url: videoURL as URL)
		let avPlayer = AVPlayer.init(playerItem: avItem)
		
		let avLayer = AVPlayerLayer.init(player: avPlayer)
		avLayer.videoGravity = .resizeAspect
		avLayer.frame = CGRect.init(x: 0, y: S_N_BAR_H, width: SCREEN_WIDTH, height: 300)
//		avLayer.videoRect
		avLayer.contentsScale = SCREEN_SCALE
		view.layer.addSublayer(avLayer)
		
		avPlayer.play()
		UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
	
    // MARK: - actions
	func shouldAutorotate() -> Bool {
		return true
	}
}
