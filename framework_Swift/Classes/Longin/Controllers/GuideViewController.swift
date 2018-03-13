//
//  GuideViewController.swift
//  framework_Swift
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // gif引导页
        self.setStaticGuidePage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - 静态图片引导页
    func setStaticGuidePage() {
        let imageNameArray: [String] = [welcome_image_one, welcome_image_two, welcome_image_three]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false, viewController: self)
        view.addSubview(guideView)
        //        UIApplication.shared.keyWindow?.rootViewController = self
        //        self.navigationController?.view.addSubview(guideView)
    }
    
    // MARK: - 动态gif
//    func setGifGuidePage() {
//        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
//        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false, viewController: self)
//        view.addSubview(guideView)
//    }
    
    // MARK: - 视频
//    func setVideoGuidePage() {
//        let urlStr = Bundle.main.path(forResource: "1.mp4", ofType: nil)
//        let videoUrl = NSURL.fileURL(withPath: urlStr!)
//        let guideView = HHGuidePageHUD.init(videoURL:videoUrl, isHiddenSkipButton: false)
//        view.addSubview(guideView)
//    }

}
