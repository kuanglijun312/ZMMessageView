//
//  ViewController.swift
//  ZMMessageView
//
//  Created by zm002 on 15/10/21.
//  Copyright © 2015年 zm002. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showMessage(sender: AnyObject) {
        ZMMessageView.show("这是提示--\(count++)")
    }
    
    

}

