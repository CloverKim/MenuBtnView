//
//  MenuBtnView.swift
//  MenuBtnView
//
//  Created by 江顺金 on 2018/5/16.
//  Copyright © 2018年 dgut.com. All rights reserved.
//

import UIKit

class MenuBtnView: UIView {

    var dismissBlock: (() -> Void)?
    var action: ((Int) -> Void)?
    var actionBtns = [UIButton]()
    var titleBtns = [UIButton]()
    var orginYArray = [CGFloat]()
    var closeBtn = UIButton(type: .custom)
    var bgView = UIView()
    var hasTabBar = false
    
    init(frame:CGRect, imageNames: [String], titleNames: [String], isFromTabBar: Bool, distance: CGFloat, selectAction:@escaping ((Int) -> Void)) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hasTabBar = isFromTabBar
        action = selectAction
        self.frame = (UIApplication.shared.keyWindow?.bounds)!
        bgView = UIView(frame: self.bounds)
        bgView.backgroundColor = .black
        bgView.alpha = 0.0
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(bgView)
        
        for i in 0..<imageNames.count + 1 {
            let btnWidth = CGFloat(i + 1) * (55 + distance)
            let y = CGFloat(self.frame.size.height) - (hasTabBar ? 119 : 75) - btnWidth - 5
            let button = UIButton(frame: CGRect(x: self.frame.size.width - 73, y: y, width: 62, height: 62))
            button.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
            
            let titleBtn = UIButton(type: .custom)
            titleBtn.frame = CGRect(x: button.frame.origin.x - 47, y: button.center.y - 10, width: 43, height: 19)
            titleBtn.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
            titleBtn.backgroundColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1)
            titleBtn.layer.cornerRadius = titleBtn.frame.size.height / 2
            
            if (i == imageNames.count) {
                button.frame = CGRect(x: self.frame.size.width - 77, y: self.frame.size.height - 75, width: 62, height: 62)
                if hasTabBar {
                    button.center = CGPoint(x: self.frame.size.width - 42, y: self.frame.size.height - 40 - 49)
                } else {
                    button.center = CGPoint(x: self.frame.size.width - 42, y: self.frame.size.height - 40)
                }
                button.backgroundColor = .clear
                button.clipsToBounds = true
                button.setImage(UIImage(named: "addItemStart"), for: .normal)
                button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
                self.closeBtn = button
            } else {
                let str = NSString(format: "%@    ", titleNames[i])
                if (str.length > 2) {
                    let font = UIFont.systemFont(ofSize: 15)
                    let dict = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
                    let size = str.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 20), options: NSStringDrawingOptions.truncatesLastVisibleLine, attributes: dict as? [NSAttributedStringKey : Any], context: nil);
                    
                    let width = size.width - titleBtn.frame.size.width + 12
                    titleBtn.frame = CGRect(x: titleBtn.frame.origin.x - width + 28, y: titleBtn.frame.origin.y, width: titleBtn.frame.size.width + width, height: titleBtn.frame.size.height)
                }
                titleBtn.setTitle(str as String, for: .normal)
                titleBtn.setTitleColor(.white, for: .normal)
                titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                titleBtns.append(titleBtn)
                self.addSubview(titleBtn)
                button.setImage(UIImage(named: imageNames[i]), for: .normal)
                actionBtns.append(button)
                button.tag = i
                button.addTarget(self, action: #selector(buttonAction(btn:)), for: .touchUpInside)
                orginYArray.append(button.frame.origin.y)
                titleBtn.frame.origin.y = self.frame.size.height - 110
                button.frame.origin.y = titleBtn.frame.origin.y
            }
            self.addSubview(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showInView(superView: UIView) {
        superView.addSubview(self)
        self.closeBtn.translatesAutoresizingMaskIntoConstraints = false
        let constraintX = NSLayoutConstraint(item: self.closeBtn, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -13)
        let constraintY = NSLayoutConstraint(item: self.closeBtn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: self.hasTabBar ? -58 : -9)
        self.addConstraint(constraintX)
        self.addConstraint(constraintY)
        
        UIView.animate(withDuration: 0.15) {
            for i in 0..<self.orginYArray.count  {
                let imageBtn  = self.actionBtns[i]
                let titleBtn = self.titleBtns[i]
                imageBtn.frame.origin.y = self.orginYArray[i]
                titleBtn.frame.origin.y = self.orginYArray[i] + 19
            }
            self.closeBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4));
            self.bgView.alpha = 0.7
        }
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.1, animations: {
            for i in 0..<self.orginYArray.count  {
                let imageBtn  = self.actionBtns[i]
                let titleBtn = self.titleBtns[i]
                imageBtn.frame.origin.y = self.frame.size.height - 70
                titleBtn.frame.origin.y = self.frame.size.height - 70
            }
            self.closeBtn.transform = CGAffineTransform(rotationAngle: 0);
            self.bgView.alpha = 0.0
        }) { (finished) in
            if self.dismissBlock != nil {
                self.dismissBlock?()
            }
            self.removeFromSuperview()
        }
    }
    
    @objc func buttonAction(btn: UIButton) {
        if (self.action != nil) {
            self.action?(btn.tag)
        }
        self.dismiss()
    }
    
    func willRotateToInterfaceOrientation() {
        self.closeBtn.transform = .identity;
    }
    
    func didRotateFromInterfaceOrientation() {
        self.closeBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4));
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss()
    }
    
    func showAnimation() -> CAAnimationGroup {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform")
        scaleAnimation.values = [NSValue(caTransform3D: CATransform3DMakeScale(3, 3, 1)), NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))]
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [0, 1]
        let animationgroup = CAAnimationGroup()
        animationgroup.animations = [scaleAnimation, opacityAnimation]
        animationgroup.duration = 0.3
        animationgroup.fillMode = kCAFillModeForwards
        
        return animationgroup
    }
}
