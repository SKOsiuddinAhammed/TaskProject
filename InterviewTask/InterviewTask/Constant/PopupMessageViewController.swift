//
//  PopupMessageViewController.swift
//  InterviewTask
//
//  Created by Ahammed on 26/06/20.
//  Copyright © 2020 Ahammed. All rights reserved.
//

import Foundation
import UIKit

class PopupMessageViewController: UIViewController {
    
    lazy var loaderContainer : UIView = {
        let navView = UIView()
        
        navView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        navView.addSubview(rightImage)
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        
        navView.addSubview(textLable)
        textLable.translatesAutoresizingMaskIntoConstraints = false
        //// Add Image View
        navView.addConstraints([
            NSLayoutConstraint(item: rightImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 30),
            NSLayoutConstraint(item: rightImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30),
            NSLayoutConstraint(item: rightImage, attribute: .left, relatedBy: .equal, toItem: navView, attribute: .left, multiplier: 1.0, constant: 5),
            NSLayoutConstraint(item: rightImage, attribute: .centerY, relatedBy: .equal, toItem: navView, attribute: .centerY, multiplier: 1.0, constant: 0),
            ])
        
        navView.addConstraints([
            NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 15),
            NSLayoutConstraint(item: closeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 15),
            NSLayoutConstraint(item: closeButton, attribute: .right, relatedBy: .equal, toItem: navView, attribute: .right, multiplier: 1.0, constant: -10),
            NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: navView, attribute: .top, multiplier: 1.0, constant: 10),
            ])
        navView.addConstraints([
            NSLayoutConstraint(item: textLable, attribute: .left, relatedBy: .equal, toItem: rightImage, attribute: .right, multiplier: 1.0, constant: 10),
            NSLayoutConstraint(item: textLable, attribute: .right, relatedBy: .equal, toItem: closeButton, attribute: .left, multiplier: 1.0, constant: 10),
            NSLayoutConstraint(item: textLable, attribute: .centerY, relatedBy: .equal, toItem: navView, attribute: .centerY, multiplier: 1.0, constant: 0),
            
            ])
        return navView
    }()
    
    lazy var rightImage : UIImageView = {
        let rightImg = UIImageView()
       // rightImg.image = #imageLiteral(resourceName: "eye")
        return rightImg
    }()
    
    lazy var closeButton:UIButton = {
        let  button = UIButton()
       // button.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var textLable : UILabel = {
        let uilable = UILabel()
        uilable.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        uilable.textAlignment = .center
        uilable.numberOfLines = 0
        uilable.sizeToFit()
        return uilable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addSuccessView(withMessage:String){
        self.removeAnimation()
        
        self.view.addSubview(loaderContainer)
        loaderContainer.translatesAutoresizingMaskIntoConstraints = false
//        loaderContainer.cornerRadius = 20
        
        loaderContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
        let attributes: [NSLayoutConstraint.Attribute] = [ .left,.right,.bottom]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: loaderContainer, attribute: $0, relatedBy: .equal, toItem: self.view, attribute: $0, multiplier: 1, constant: 0)
        })
        loaderContainer.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.6196078431, blue: 0.9254901961, alpha: 1)
        
        textLable.text = withMessage;
        
    }
   @objc func closeButtonClick(){
        self.removeView()
    }
    private func removeAnimation(){
        applicationController?.delay(2) {
            self.removeView()
        }
    }
    
    private func removeView(){
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);
        }) {(completion)   in
            self.dismiss(animated: true, completion: {
                
            })
            self.loaderContainer.removeFromSuperview()
            self.closeButton.removeFromSuperview()
            self.rightImage.removeFromSuperview()
            self.textLable.removeFromSuperview()
            self.view.removeFromSuperview()
           // self.removeFromParentViewController()
            
        }
    }
}
