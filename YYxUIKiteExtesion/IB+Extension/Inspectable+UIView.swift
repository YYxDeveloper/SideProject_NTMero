//
//  Inspectable+UIView.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/21.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable var radiusAngle: CGFloat {
           get {
               return self.layer.cornerRadius
           }
           set {
              self.layer.cornerRadius = newValue
           }
       }
    @IBInspectable var borderColor: UIColor {
          get {
              return UIColor(cgColor: self.layer.borderColor ?? UIColor.red.cgColor)
          }
          set {
              self.layer.borderColor = newValue.cgColor
          }
      }
      @IBInspectable var borderWidth: CGFloat {
            get {
                return self.layer.borderWidth
            }
            set {
                self.layer.borderWidth = newValue
            }
        }//adjustsFontSizeToFitWidth
    
}
extension UILabel{
    //adjustsFontSizeToFitWidth
//    @IBInspectable var adjustsFontSizeToFitWidth: Bool {
//           get {
//               return self.adjustsFontSizeToFitWidth
//           }
//           set {
//              self.adjustsFontSizeToFitWidth = newValue
//           }
//       }
}
