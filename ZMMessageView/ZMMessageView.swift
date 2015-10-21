//
//  ZMMessageView.swift
//  Innfu
//
//  Created by qingyin02 on 15/5/17.
//  Copyright (c) 2015年 zmaitech. All rights reserved.
//

import UIKit

func colorFromHex (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }
    
    if (cString.characters.count != 6) {
        return UIColor.grayColor()
    }
    
    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class ZMMessageView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let zmBackgroundColor = colorFromHex( "#ffeea8")
    let zmTextColor = colorFromHex( "#666666").colorWithAlphaComponent(0.8)
    let screenWidth = UIScreen.mainScreen().bounds.width

    var applicationKeyWindow:UIWindow!
    var heartbeatImageView:UIImageView!
    var msgLabel:UILabel!
    
    // 参考 https://github.com/hpique/SwiftSingleton
    static let sharedInstance = ZMMessageView()
    
    init() {
        super.init(frame: CGRectMake(0, 64, screenWidth, 30))
        
        msgLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, 30))
        msgLabel.font = msgLabel.font.fontWithSize(14)
        msgLabel.textColor = zmTextColor
        msgLabel.textAlignment = NSTextAlignment.Center
        
        self.addSubview(msgLabel)
        
        //有一定的透明度
        self.backgroundColor = zmBackgroundColor
        
        let tapAction = UITapGestureRecognizer(target: self, action: "dismissSelf")
        self.addGestureRecognizer(tapAction)
        self.alpha = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func show(msg:String) {
        self.show(msg, top: 64)
    }
    
    class func show(msg:String,top:CGFloat) {
        // get window
        var applicationKeyWindow:UIWindow! = nil
        let frontToBackWindows = UIApplication.sharedApplication().windows//Mark: -x7
        for window in frontToBackWindows {
            if window.windowLevel == UIWindowLevelNormal {
                applicationKeyWindow = window;
                break
            }
        }
        if applicationKeyWindow == nil {
            return
        }
        applicationKeyWindow.addSubview(ZMMessageView.sharedInstance)
        
        ZMMessageView.sharedInstance.msgLabel.text = msg
        
        //去掉所有的动画
        ZMMessageView.sharedInstance.layer.removeAllAnimations()
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            ZMMessageView.sharedInstance.alpha = 1
            }) { (finished) -> Void in
                let delay = 2 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    ZMMessageView.dismiss()
                }
        }
    }
    
    class func dismiss() {
        if ZMMessageView.sharedInstance.alpha != 0 {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                ZMMessageView.sharedInstance.alpha = 0
                }) { (finished) -> Void in
                    
            }
        }
    }
    
    func dismissSelf() {
        ZMMessageView.dismiss()
    }
}
