//
//  BaseTabbarController.swift
//  smart_Swift
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置tabbar 底部文字选中色
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = kThemeMainColor
        
        addChildViewController()
        
    }
    
    
    func addChildViewController() {
        setChildViewController(DeviceViewController(), title: text_mainTabbarDevice, imageName: main_tabbar_device_normal_image_name, selectedImageName: main_tabbar_device_selector_image_name)
        setChildViewController(SceneViewController(), title: text_mainTabbarScene, imageName: main_tabbar_scene_normal_image_name, selectedImageName: main_tabbar_scene_selector_image_name)
        setChildViewController(MineViewController(), title: text_mainTabbarMine, imageName: main_tabbar_mine_normal_image_name, selectedImageName: main_tabbar_mine_selector_image_name)
    }
    
    
    func setChildViewController(_ childController: UIViewController, title: String, imageName:String, selectedImageName:String) {
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        
        let naviVC = BaseNavigationController(rootViewController: childController)
        
        addChildViewController(naviVC)
    }
    

}
