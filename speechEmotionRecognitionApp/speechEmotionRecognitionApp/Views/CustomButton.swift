//
//  CustomButton.swift
//  speechEmotionRecognitionApp
//
//  Created by Simran Dhillon on 2/2/19.
//  Copyright © 2019 Simran Dhillon. All rights reserved.
//
/* CustomButton extends the normal UIButton with rounded edges
 */

import Foundation

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
}
