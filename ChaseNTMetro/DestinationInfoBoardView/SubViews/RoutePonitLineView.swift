//
//  RoutePonitLineView.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/26.
//

import Foundation
import UIKit
class RoutePonitLineView: UIView {
    private var stationType:stationType
    private var stationColorType:NTMetroStaticDatas.stationColorType
    
    static let lineWidth = 10
    static let lineRadius = CGFloat(RoutePonitLineView.lineWidth/2)
    
    static let circleRadius:CGFloat = 8
    
    lazy var line:UIView = {
        let line = UIView()
        line.backgroundColor = modifyColor()
       
        
        return line
    }()
    private func modifyColor() -> UIColor{
        switch self.stationColorType{
        
        case .red:
            return NTMetroStaticDatas.colors.redLine
        case .blue:
            return NTMetroStaticDatas.colors.blueLine
        case .green:
            return NTMetroStaticDatas.colors.greenLine
        }
    }
    lazy var circle:UIView = {
        let circle = UIView()
        circle.backgroundColor = modifyColor()
        circle.layer.cornerRadius = RoutePonitLineView.circleRadius
        circle.layer.borderWidth = 2
        circle.layer.borderColor = UIColor.white.cgColor
        return circle
        
    }()
    lazy var triangleView:UIView = {
        let triangle = UIView()
        let length = RoutePonitLineView.lineWidth
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: 0))
        path2.addLine(to: CGPoint(x: length, y: 0))
        path2.addLine(to: CGPoint(x: length/2, y: length/2))
        path2.addLine(to: CGPoint(x: 0, y: 0))
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = modifyColor().cgColor
        
        triangle.layer.addSublayer(shapeLayer2)
        return triangle
    }()
    lazy var transferVierticalLine:UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        
        let blueView = UIView()
        blueView.backgroundColor =  NTMetroStaticDatas.colors.blueLine
        blueView.roundCorners(corners: [.layerMaxXMaxYCorner], radius: RoutePonitLineView.lineRadius)
        let greenView = UIView()
        greenView.backgroundColor =  NTMetroStaticDatas.colors.greenLine
        greenView.roundCorners(corners: [.layerMinXMaxYCorner], radius: RoutePonitLineView.lineRadius)
        
        
        stack.addArrangedSubview(blueView)
        stack.addArrangedSubview(greenView)
        return stack
    }()
    lazy var transferGreenLine:UIView = {
        let transferGreenLine = UIView()
        transferGreenLine.backgroundColor = NTMetroStaticDatas.colors.greenLine
        transferGreenLine.roundCorners(corners: [.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: RoutePonitLineView.lineRadius)

        return transferGreenLine
    }()
    lazy var transferBlueLine:UIView = {
        let transferBlueLine = UIView()
        transferBlueLine.backgroundColor = NTMetroStaticDatas.colors.blueLine
        transferBlueLine.roundCorners(corners: [.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: RoutePonitLineView.lineRadius)
        return transferBlueLine
        
    }()
    enum stationType {
        case regular,transfer
    }
    convenience init(stationType:stationType,stationColorType:NTMetroStaticDatas.stationColorType) {
        self.init(frame: .zero)
        self.stationType = stationType
        self.stationColorType = stationColorType
        addThisSubViews()
        layoutThisView()
    }
    override init(frame: CGRect) {
        self.stationType = .regular
        self.stationColorType = .red
        super.init(frame: frame)
       
        //        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addThisSubViews(){
        addSubview(line)
        addSubview(circle)
        
        switch self.stationType {
        case .regular:
            addSubview(triangleView)
        case .transfer:
            addSubview(transferVierticalLine)
            addSubview(transferBlueLine)
            addSubview(transferGreenLine)
        }
        
       
        
    }
    private func layoutThisView(){
        line.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().offset(-RoutePonitLineView.lineWidth)
            make.width.equalTo(RoutePonitLineView.lineWidth)
            
            
        })
        circle.snp.makeConstraints({make in
            make.center.equalToSuperview()
            make.height.width.equalTo(RoutePonitLineView.circleRadius * 2)
            
        })
        
       
        switch self.stationType {
        case .regular:
            triangleView.snp.makeConstraints({make in
                make.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.height.equalTo(RoutePonitLineView.lineWidth)
            })
        case .transfer:
            transferVierticalLine.snp.makeConstraints({make in
                make.centerX.equalToSuperview()
                make.top.equalTo(circle.snp.bottom).offset(-1)
                make.bottom.equalToSuperview()
                make.width.equalTo(RoutePonitLineView.lineWidth)
                
            })
            transferBlueLine.snp.makeConstraints({make in
                //往左邊
                make.height.equalTo(RoutePonitLineView.lineWidth)
                make.bottom.equalToSuperview()
                make.trailing.equalTo(transferVierticalLine.snp.leading)
                make.width.equalToSuperview().dividedBy(4)
            })
            transferGreenLine.snp.makeConstraints({make in
                //往右邊
                make.height.equalTo(RoutePonitLineView.lineWidth)
                make.bottom.equalToSuperview()
                make.leading.equalTo(transferVierticalLine.snp.trailing)
                make.width.equalToSuperview().dividedBy(4)
            })
        }
    }
}
class StationInfomationView: UIView {
    private var stationType:RoutePonitLineView.stationType
    private var stationColorType:NTMetroStaticDatas.stationColorType
    lazy var routePonitLineView:RoutePonitLineView = {
        
        let routePonitLineView = RoutePonitLineView(stationType: self.stationType, stationColorType: self.stationColorType)
        
        return routePonitLineView
    }()
    
    
    convenience init(stationType:RoutePonitLineView.stationType,stationColorType:NTMetroStaticDatas.stationColorType) {
        self.init(frame: .zero)
        self.stationType = stationType
        self.stationColorType = stationColorType
        self.backgroundColor = .black
        addThisSubViews()
        layoutThisView()
    }
    override init(frame: CGRect) {
        self.stationType = .regular
        self.stationColorType = .red
        super.init(frame: frame)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addThisSubViews(){
        addSubview(routePonitLineView)
    }
    private func layoutThisView(){
        routePonitLineView.snp.makeConstraints({make in
            make.center.width.height.equalToSuperview()
            
            
        })
    }
}
