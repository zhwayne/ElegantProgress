//
//  ViewController.swift
//  ElegantProgress
//
//  Created by wayne on 15/6/17.
//  Copyright © 2015年 wayne. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    var progressView: ElegantProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = CGRectMake(0, 0, 260, 260)
        let center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
        progressView = ElegantProgressView(frame: bounds)
        progressView.center = center
        
        self.view.addSubview(progressView)
    }
}

