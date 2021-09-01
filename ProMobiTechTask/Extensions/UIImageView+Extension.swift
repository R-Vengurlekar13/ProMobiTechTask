//
//  UIImageView+Extension.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setCornerRadius(radius:CGFloat) {
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
