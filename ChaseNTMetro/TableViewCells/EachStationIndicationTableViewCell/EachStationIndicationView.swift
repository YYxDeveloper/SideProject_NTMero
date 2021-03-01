//
//  EachStationIndicationView.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/29.
//

import UIKit

class EachStationIndicationView: UIView {

    @IBOutlet weak var xibVIew: UIView!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var circleDotView: UIView!
    @IBOutlet weak var upTriangleView: UIView!
    @IBOutlet weak var downTriangleView: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    var upTriangleShape = CAShapeLayer()
    var downTriangleShape = CAShapeLayer()

    static let nibName = String(describing: EachStationIndicationView.self)
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
         self.upTriangleView.setUpTriangle(triangleColor: NTMetroStaticDatas.colors.redLine, shape: upTriangleShape)
        self.downTriangleView.setUpTriangle(triangleColor: NTMetroStaticDatas.colors.redLine, shape: downTriangleShape)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        let view =  Bundle.main.loadNibNamed(EachStationIndicationView.nibName, owner: self, options: nil)?.first as! UIView
        view.frame = bounds;
        addSubview(view)
    }
    private func changeEndLineColor(lineColor:UIColor) {
        
        self.upTriangleShape.fillColor = lineColor.cgColor
        self.downTriangleShape.fillColor = lineColor.cgColor
        
    }
}
extension EachStationIndicationView{
    //Open
   
    enum arrowDirection {
        case down,up
    }
    func changeStateAttribution(lineColor:UIColor,arrowDirection:arrowDirection) {
        self.circleDotView.backgroundColor = lineColor
        

        
        switch arrowDirection {
        case .down:
           
            self.upTriangleView.setDownTriangle(triangleColor: lineColor, shape: upTriangleShape)
            
            self.downTriangleView.setDownTriangle(triangleColor: lineColor, shape: downTriangleShape)
        case .up:
            self.upTriangleView.setUpTriangle(triangleColor: lineColor, shape: upTriangleShape)
            
            self.downTriangleView.setUpTriangle(triangleColor: lineColor, shape: downTriangleShape)
        }
        UIView.animate(withDuration: 0.5, animations: {self.layoutIfNeeded()})
    }
}
