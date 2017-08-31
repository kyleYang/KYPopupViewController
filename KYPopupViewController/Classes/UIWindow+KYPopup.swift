//
//  UIWindow+KYPopup.swift
//  Pods
//
//  Created by Kyle on 2017/8/29.
//
//

import UIKit


public extension UIWindow{

    public func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }

    public class func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {

        if let navigationController = vc as? UINavigationController{
            return UIWindow.getVisibleViewControllerFrom( vc: navigationController.visibleViewController!)
        }else if let tabBarController = vc as? UITabBarController{
            return UIWindow.getVisibleViewControllerFrom(vc: tabBarController.selectedViewController!)
        }else if let presentedViewController = vc.presentedViewController{
            if let subPresentedViewController = presentedViewController.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: subPresentedViewController)
            }else{
                return vc
            }
        }else{
            return vc
        }
    }


    public class func topViewController()->UIViewController?{
        guard let windows = UIApplication.shared.keyWindow else{
            return nil;
        }
        return windows.visibleViewController()

    }

}
