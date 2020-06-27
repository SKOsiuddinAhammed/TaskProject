//
//  ApplicationController.swift
//  InterviewTask
//
//  Created by Ahammed on 26/06/20.
//  Copyright © 2020 Ahammed. All rights reserved.
//

import Foundation
import UIKit
class ApplicationController: NSObject {
    static  let shared = ApplicationController()
    private override init() {
        super.init()
    }
    //MARK:- DILAY FUNCTION
       func delay(_ delay:Double, closure:@escaping ()->()) {
           let when = DispatchTime.now() + delay
           DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
       }
     // MARK:- SHOW POPUP
    func SHOW_POPUP_MESSAGE(on:UIViewController,withMessage:String)  {
        DispatchQueue.main.async {
            let vc = PopupMessageViewController()
            vc.addSuccessView(withMessage: withMessage)
            on.addChild(vc)
            vc.view.frame = on.view.frame
            on.view.addSubview(vc.view)
        }
    }
}
