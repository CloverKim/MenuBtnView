//
//  ViewController.swift
//  Example
//
//  Created by 江顺金 on 2018/5/18.
//  Copyright © 2018年 dgut.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var actionBtn = UIButton(type: .custom)
    var menuView: MenuBtnView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionBtn.frame = CGRect(x: 100, y: 100, width: 69, height: 69)
        actionBtn.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        actionBtn.setImage(#imageLiteral(resourceName: "addItemStart"), for: UIControl.State())
        actionBtn.backgroundColor = UIColor.clear
        actionBtn.layer.cornerRadius = actionBtn.frame.size.width / 2
        actionBtn.addTarget(self, action:#selector(showMenu), for: .touchUpInside)
        actionBtn.center = CGPoint(x: view.frame.size.width - 42, y: view.frame.size.height - 40)
        view.addSubview(actionBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func showMenu() {
        let imageNames = ["lefttime_schedule", "lefttime_memo", "lefttime_riji"]
        let titleNames = [NSLocalizedString("提醒", comment: ""), NSLocalizedString("备忘", comment: ""), NSLocalizedString("日记", comment: "")]
        menuView = MenuBtnView(frame: view.frame, imageNames: imageNames, titleNames: titleNames, isFromTabBar: false, distance: 8, selectAction: { (index) in
            print(titleNames[index])
        })
        
        menuView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        menuView?.showInView(superView: view)
        
        menuView?.dismissBlock = { [weak self] in
            self?.menuView = nil
            self?.actionBtn.isHidden = false
        }
        actionBtn.isHidden = true
    }

}

