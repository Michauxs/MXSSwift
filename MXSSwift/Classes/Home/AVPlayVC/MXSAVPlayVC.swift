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

	var isHideStatusBar : Bool?
	
	var videoName : String?
	var avPlayer :AVPlayer?
	
	var BtmControlView : UIView?
	var pauseResumBtn :UIButton?
	var progressSecond :UILabel?
	var progressView : UIView?
	
	var autoActionTimer :Timer?
	var secondCount : CGFloat = 0
	var idleCount : CGFloat = 0
	
	var moniInterval : TimeInterval = 0.1
	var time_node : Double = 0
	var pan_node : CGFloat = 0
	
	override func receiveArgsBePost(args: Any) {
		videoName = args as? String
		isHideStatusBar = false
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
//		UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
		
		super.bindingNavBar()
		
		let docuDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let videoURL = NSURL.init(fileURLWithPath: docuDir.first!+"/"+videoName!)
		
		let avItem = AVPlayerItem.init(url: videoURL as URL)
		avPlayer = AVPlayer.init(playerItem: avItem)
		
		let avLayer = AVPlayerLayer.init(player: avPlayer)
		avLayer.videoGravity = .resizeAspect
		MXSLog("x:" + "\(view.frame.origin.x)\n" + "y:" + "\(view.frame.origin.y)\n" + "w:" + "\(view.frame.size.width)\n" + "h:" + "\(view.frame.size.height)\n")
		avLayer.frame = CGRect.init(x: 0, y: 0, width: SCREEN_HEIGHT, height: SCREEN_WIDTH)
		avLayer.contentsScale = SCREEN_SCALE
		view.layer.addSublayer(avLayer)
		
		NotificationCenter.default.addObserver(self, selector: #selector(playFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer?.currentItem)
		
		autoActionTimer = Timer.scheduledTimer(timeInterval: moniInterval, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
		autoActionTimer?.fireDate = Date.distantFuture
		
		BtmControlView = UIView.init()
		BtmControlView?.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
		view.addSubview(BtmControlView!)
		BtmControlView!.snp.makeConstraints { (make) in
			make.bottom.equalTo(view)
			make.left.equalTo(view)
			make.right.equalTo(view)
			make.height.equalTo(BTM_COMMON_H)
		}
		pauseResumBtn = UIButton.init()
		pauseResumBtn?.setImage(UIImage.init(named: "play_icon_pause"), for: .normal)
		pauseResumBtn?.setImage(UIImage.init(named: "play_icon_start"), for: .selected)
		BtmControlView?.addSubview(pauseResumBtn!)
		pauseResumBtn!.snp.makeConstraints { (make) in
			make.left.equalTo(BtmControlView!).offset(10)
			make.centerY.equalTo(BtmControlView!)
			make.size.equalTo(CGSize.init(width: 40, height: 40))
		}
		pauseResumBtn?.addTarget(self, action: #selector(pauseResumClicked(_:)), for: .touchUpInside)
		let progressViewBg = UIView.init()
		progressViewBg.backgroundColor = UIColor.black
		view.addSubview(progressViewBg)
		progressViewBg.snp.makeConstraints { (make) in
			make.top.equalTo(BtmControlView!)
			make.left.equalTo(BtmControlView!)
			make.right.equalTo(BtmControlView!)
			make.height.equalTo(1)
		}
		progressView = UIView.init()
		progressView?.backgroundColor = UIColor.orange
		view.addSubview(progressView!)
		progressView!.snp.makeConstraints { (make) in
			make.top.equalTo(BtmControlView!)
			make.left.equalTo(BtmControlView!)
//			make.right.equalTo(BtmControlView!)
			make.width.equalTo(0)
			make.height.equalTo(1)
		}
		progressSecond = UILabel.init(text: "00:00/00:00", fontSize: 14, textColor: .white, alignment: .right)
		BtmControlView?.addSubview(progressSecond!)
		progressSecond!.snp.makeConstraints { (make) in
			make.right.equalTo(BtmControlView!).offset(-15)
			make.centerY.equalTo(BtmControlView!)
		}
		
		view.bringSubview(toFront: NavBar!)
		
		view.isUserInteractionEnabled = true
		view.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(panGestrueAction(_:))))
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		avPlayer?.play()
		autoActionTimer?.fireDate = Date.distantPast
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		autoActionTimer?.fireDate = Date.distantFuture
		autoActionTimer?.invalidate()
	}
	
	// MARK: - layout
	override func NavBarLayout() {
//		NavBar?.frame = CGRect.init(x: 0, y: STATUS_BAR_H, width: SCREEN_HEIGHT, height: NAV_BAR_H)
		super.NavBarLayout()
		NavBar?.setBackground(color: UIColor.init(white: 0, alpha: 0.4))
		NavBar?.btmLineView?.isHidden = true
	}
	
    // MARK: - actions
	@objc func panGestrueAction (_ pan:UIPanGestureRecognizer) {
		
		time_node  = 0
		pan_node = 0
		let state = pan.state
		switch state {
		case .began: do {
			avPlayer?.pause()
			autoActionTimer?.fireDate = Date.distantFuture
			time_node = (avPlayer!.currentItem?.currentTime().seconds)!
			pan_node = pan.translation(in: view).x
			
			}
		case .changed : do {
			let duration = avPlayer?.currentItem?.duration.seconds
			let p = pan.translation(in: view).x
			let changed = p - pan_node
			progressView?.snp.updateConstraints({ (make) in
				make.width.equalTo(SCREEN_HEIGHT*(CGFloat.init(time_node)+pan_node+changed)/CGFloat.init(duration!))
			})
			
			}
		case .ended : do {
			
			let p = pan.translation(in: view).x
			let video_real_changed = p - pan_node + CGFloat.init(time_node)
			avPlayer?.currentItem?.seek(to: CMTime.init(seconds: Double.init(video_real_changed), preferredTimescale: 1), completionHandler: { (complete) in
				self.avPlayer?.play()
				self.autoActionTimer?.fireDate = Date.distantPast
			})
			}
		default : do {
			
			}
			
		}
	}
	
	@objc func playFinished () {
		autoActionTimer?.fireDate = Date.distantFuture
		autoActionTimer?.invalidate()
		didNavBarLeftClick()
	}
	@objc func pauseResumClicked (_ btn:UIButton) {
		if btn.isSelected {
			avPlayer?.play()
		} else {
			avPlayer?.pause()
		}
		btn.isSelected = !btn.isSelected
	}
	
	@objc func timerRun () {
		
		let duration = (avPlayer!.currentItem?.duration.seconds)!
		let current = (avPlayer!.currentItem?.currentTime().seconds)!
		
		progressView?.snp.updateConstraints({ (make) in
			make.width.equalTo(SCREEN_HEIGHT*CGFloat.init(current/duration))
		})
		
		let second_d = Int(duration)/60;
		let miniter_d = Int(duration)%60;
		let second_t = Int(current)/60;
		let miniter_t = Int(current)%60;
		
		let str = String(format: "%.2d:%.2d/%.2d:%.2d", arguments: [second_t, miniter_t, second_d, miniter_d])
		progressSecond?.text = str
		
		idleCount = idleCount + CGFloat(moniInterval)
		print("timer run:" + "\(idleCount)")
	}
	
	// MARK: - system
	override var shouldAutorotate: Bool {
		return true
	}
	
	override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
		return .landscapeRight
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		let r = UInt8(UIInterfaceOrientationMask.landscapeRight.rawValue) | UInt8(UIInterfaceOrientationMask.landscapeLeft.rawValue)
		return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.RawValue(r))
	}
	
	override var prefersStatusBarHidden: Bool {
		return isHideStatusBar!
	}
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	// MARK: - nitifies
	override func didNavBarLeftClick() {
		MXSVCExchangeCmd.shared.DismissVC(self, args: MXSNothing.shared)
	}
}
