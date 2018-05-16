//
//  GJSProgressHUD.swift
//  GaoYuanFeng
//
//  Created by hsrd on 2018/4/13.
//  Copyright © 2018年 HSRD. All rights reserved.
//

import UIKit

class GJSProgressHUD: NSObject {
    private static let back = UIView()
    //动画状态
    class func showStatus(string : String)
    {
        back.frame = UIScreen.main.bounds
        back.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        
        let alertView = UIView.init(frame: CGRect(x: UIScreen.main.bounds.width/2-90, y: UIScreen.main.bounds.height/2-22.5, width: 180, height: 45))
        alertView.backgroundColor = UIColor.white
        let backimage = UIImageView.init(frame: alertView.bounds)
        backimage.image = UIImage.init(named: "backimage.png")
        alertView.addSubview(backimage)
        back.addSubview(alertView)
        
        let icon = UIImageView.init(frame: CGRect(x: 15, y: alertView.frame.height/2-15, width: 30, height: 30))
        icon.image = UIImage.init(named: "mbscroll.png")
        alertView.addSubview(icon)
        let an = CABasicAnimation.init(keyPath: "transform.rotation.z")
        an.fromValue = NSNumber.init(value: 0)
        an.toValue = NSNumber.init(value: Double.pi*2)
        an.duration = 1
        an.autoreverses = false
        an.fillMode = kCAFillModeForwards
        an.repeatCount = MAXFLOAT
        icon.layer.add(an, forKey: nil)
        
        let titleLabel = UILabel.init(frame: CGRect(x:icon.frame.maxX+15 , y: alertView.frame.height/2-15, width: 100, height: 30))
        titleLabel.textColor = UIColor.white
        
        titleLabel.text = NSString( format : "%@...",string) as String
        
        alertView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        UIApplication.shared.keyWindow?.addSubview(back)
        
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 3
    }
    
    //文字提示
    class func showString(string : String)
    {
        back.frame = UIScreen.main.bounds
        back.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let alertView = UIView.init(frame: CGRect(x: UIScreen.main.bounds.width/2-90, y: UIScreen.main.bounds.height/2-20, width: 180, height: 40))
        alertView.backgroundColor = UIColor.white
        let backimage = UIImageView.init(frame: alertView.bounds)
        backimage.image = UIImage.init(named: "backimage.png")
        alertView.addSubview(backimage)
        back.addSubview(alertView)
        
        let titleLabel = UILabel.init(frame: CGRect(x:alertView.frame.width/2-80, y: alertView.frame.height/2-15, width: 160, height: 30))
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = string
        
        alertView.addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        UIApplication.shared.keyWindow?.addSubview(back)
        
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 3
        
        alertView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            alertView.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            back .removeFromSuperview()
        }
    }
    
    class func dismiss()
    {
        back.removeFromSuperview()
    }
    
    private static let freshBu = UIButton()
    
    //首页刷新
    class func homeShow()
    {
        UIView.animate(withDuration: 0.25, animations:
            {
            freshBu.alpha = 1
        })
        freshBu.frame = CGRect(x: 15, y:UIScreen.main.bounds.height-80-75 , width: 60, height: 60)
        freshBu.setImage(UIImage.init(named: "map_fresh.png"), for: UIControlState.normal)
        let an = CABasicAnimation.init(keyPath: "transform.rotation.z")
        an.fromValue = NSNumber.init(value: 0)
        an.toValue = NSNumber.init(value: Double.pi*2)
        an.duration = 1
        an.autoreverses = false
        an.fillMode = kCAFillModeForwards
        an.repeatCount = MAXFLOAT
        freshBu.layer.add(an, forKey: nil)
        
        freshBu.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        UIApplication.shared.keyWindow?.addSubview(freshBu)
    }
    
    class func homeDismiss()
    {
        UIView.animate(withDuration: 0.25, animations:
            {
            freshBu.alpha = 0
        })
    }
}
