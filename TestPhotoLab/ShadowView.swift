//
//  ShadowView.swift
//  TestPhotoLab
//
//  Created by Alexander Avdacev on 16.02.22.
//

import Foundation
import UIKit

class ShadowView: UIView {
    
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    var shadowOpacity: Float = 0.7 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    var shadowOffset = CGSize(width: 2.5, height: 2.5) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    var shadowRadius: CGFloat = 7.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    private func setupShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.cornerRadius = 10.0
    }
    
    private func setup() {
        
    }
}
