//
//  ViewController.swift
//  KYPopupViewController
//
//  Created by kyleYang on 08/28/2017.
//  Copyright (c) 2017 kyleYang. All rights reserved.
//

import UIKit
import KYPopupViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    @IBAction func show(_ sender: Any) {
        
        let alert = KYAlertViewController(title: "提示", message: "确定删除")
        let button = KYPopupButton(title: "删除") {

        }
        let button2 = KYPopupButton(title: "确定") {

        }
        alert.addButton(button)
        alert.addButton(button2)
        alert.bePresented()
    }


}

