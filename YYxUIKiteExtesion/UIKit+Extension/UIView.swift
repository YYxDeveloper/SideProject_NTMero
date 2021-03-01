//
//  UIView.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/25.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners:  CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = false
        self.layer.maskedCorners = corners
    }
    func setUpTriangle(triangleColor:UIColor,shape:CAShapeLayer){
        //https://stackoverflow.com/questions/34416012/creating-triangle-with-uibezierpath-in-swift
        let heightWidth = self.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        
        let shape = shape
        shape.path = path
        shape.fillColor = triangleColor.cgColor
        
        self .layer.insertSublayer(shape, at: 0)
        
        
    }
    func setDownTriangle(triangleColor:UIColor,shape:CAShapeLayer) {
        let heightWidth = self.frame.size.width
           let path = CGMutablePath()

           path.move(to: CGPoint(x: 0, y: 0))
           path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth))
           path.addLine(to: CGPoint(x:heightWidth, y:0))
           path.addLine(to: CGPoint(x:0, y:0))

           let shape = shape
           shape.path = path
           shape.fillColor = triangleColor.cgColor

           self.layer.insertSublayer(shape, at: 0)
       
       }
}
