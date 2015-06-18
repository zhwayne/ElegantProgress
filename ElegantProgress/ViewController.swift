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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            for i in 0...100 {
                if i < 40 {
                    NSThread.sleepForTimeInterval(0.03)
                }
                else if i < 60 {
                    NSThread.sleepForTimeInterval(0.1)
                }
                else {
                    NSThread.sleepForTimeInterval(0.01)
                }
                let progress = Double(i) / 100.0
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.progressView.progress = CGFloat(progress)
                })
            }
        }
    }
}

