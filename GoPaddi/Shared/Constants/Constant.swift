//
//  Constant.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import Foundation
import UIKit

class Constant {

    static func lightHaptic(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var statusBarFrameHeight: CGFloat {
        if #available(iOS 13.0, *) {
//            return UIWindow.keyWindow.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
            return 40
        }
        else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
   
    
//    static var navWithStatusBarHeight1: CGFloat {
//        return (self.navigationController?.navigationBar.bounds.height ?? 0) + UIApplication.shared.statusBarFrame.height
//    }
    
    static var navWithStatusBarHeight: CGFloat {
        return statusBarFrameHeight + 44 // 44 is the nabar height
    }
    
//    static var navWithStatusBarHeight2: CGFloat {
//        return (UIWindow.key?.rootViewController?.navigationController?.navigationBar.bounds.height ?? 0) + statusBarFrameHeight
//    }

}
