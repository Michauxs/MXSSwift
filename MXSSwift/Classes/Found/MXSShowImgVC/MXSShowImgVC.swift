//
//  MXSShowImgVC.swift
//  MXSSwift
//
//  Created by Sunfei on 2018/6/4.
//  Copyright © 2018年 MXS. All rights reserved.
//

import UIKit

class MXSShowImgVC: MXSBaseVC {

    var imageName : String?
    var showImgView : UIImageView?
    var lastScaleFactor : CGFloat = 1.0
    var netTranslation : CGPoint = CGPoint.init(x: 0.0, y: 0.0)
    
    override func receiveArgsBePost(args: Any) {
        imageName = args as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray;
        
        showImgView = UIImageView.init()
        showImgView?.contentMode = .scaleAspectFit
        view.addSubview(showImgView!)
        showImgView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(view);
        })
        
        updateShowImage()
        
        view.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        view.addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        view.addGestureRecognizer(pressGesture)
    }
    
    @objc func handleLongPressGesture (press:UILongPressGestureRecognizer) {
        if press.state == .began {
            let sheet = UIAlertController.init(title: "提示", message: "请选择", preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction.init(title: "删除", style: .destructive, handler: { (alert:UIAlertAction!) in
                MXSFileStorageCmd.shared.delImageWithName(self.imageName!)
                
                let indexCurrent = MXSSingletonCmd.shared.FileImageNams.index(of: self.imageName!)
                if indexCurrent! < MXSSingletonCmd.shared.FileImageNams.count - 1 {
                    self.imageName = MXSSingletonCmd.shared.FileImageNams[indexCurrent!+1]
                    self.updateShowImage()
                }
            }))
            sheet.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alert:UIAlertAction!) in
                
            }))
            present(sheet, animated: false, completion: nil)
        }
    }
    
    @objc func handleTapGesture (tap:UITapGestureRecognizer) {
        let tapPoint : CGPoint = tap.location(in: view)
        let p_x = tapPoint.x
        let indexCurrent = MXSSingletonCmd.shared.FileImageNams.index(of: imageName!)
        
        if p_x < SCREEN_WIDTH/3 {
            if indexCurrent != 0 {
                imageName = MXSSingletonCmd.shared.FileImageNams[indexCurrent!-1]
            } else {return}
        } else if p_x < SCREEN_WIDTH/3*2 {
            MXSVCExchangeCmd.shared.SourseVCPop(sourse: self, args: imageName!)
            return
        } else {
            if indexCurrent! < MXSSingletonCmd.shared.FileImageNams.count - 1 {
                imageName = MXSSingletonCmd.shared.FileImageNams[indexCurrent!+1]
            } else {return}
        }
        updateShowImage()
    }
    
    @objc func handlePinchGesture (pinch:UIPinchGestureRecognizer) {
        let factor = pinch.scale
        if factor > 1 {     //图片放大
            showImgView?.transform = CGAffineTransform(scaleX: lastScaleFactor+factor-1, y: lastScaleFactor+factor-1)
        } else {     //缩小
            showImgView?.transform = CGAffineTransform(scaleX: lastScaleFactor*factor, y: lastScaleFactor*factor)
        }
        
        if pinch.state == .ended {      //状态是否结束，如果结束保存数据
            if factor > 1 {
                lastScaleFactor = lastScaleFactor + factor - 1
            } else {
                lastScaleFactor = lastScaleFactor * factor
            }
        }
    }
    
    @objc func handlePanGesture (pan:UIPanGestureRecognizer) {
        
        let translation : CGPoint = pan.translation(in: view)
        switch pan.state {
        case .began: do {
            netTranslation = showImgView!.center
        }
        case .changed: do {
                showImgView?.center = CGPoint.init(x: netTranslation.x+translation.x, y: netTranslation.y+translation.y)
        }
        default: do {}
        }
    }
    
    public func updateShowImage () {
        if imageName!.hasSuffix(".gif") {
            let data = MXSFileStorageCmd.shared.loadImageDataWithName(imageName!)
            let options: NSDictionary = [kCGImageSourceShouldCache as String: NSNumber(value: true), kCGImageSourceTypeIdentifierHint as String: "kUTTypeGIF"]
            guard let imageSource = CGImageSourceCreateWithData(data, options) else { return }
            
            let frameCount = CGImageSourceGetCount(imageSource)
            var images = [UIImage]()
            var gifDuration = 0.0
            
            for i in 0 ..< frameCount {
                guard let imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, options) else { return }
                if frameCount == 1 {
                    gifDuration = Double.infinity
                } else {
                    // 获取到 gif每帧时间间隔
                    guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) ,
                        let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                        let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else { return }
                    
                    gifDuration += frameDuration.doubleValue
                    let image = UIImage.init(cgImage: imageRef, scale: UIScreen.main.scale, orientation: .up)  // 获取帧的img
                    images.append(image)
                }
            }
            
            showImgView!.animationImages = images
            showImgView!.animationDuration = gifDuration
            showImgView!.animationRepeatCount = 0 // 无限循环
            showImgView!.startAnimating()
            
        } else {
            showImgView!.animationImages = nil
            showImgView?.image = MXSFileStorageCmd.shared.loadImageWithName(imageName!)
        }
        
        
    }
    
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
