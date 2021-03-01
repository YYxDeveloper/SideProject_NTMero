//
//  NarrowedNavigationButton.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/29.
//

import Foundation
import UIKit
extension DestinationInfoBoardView{
    class NarrowedNavigationButton: UIButton {
        static let heigt = DestinationInfoBoardView.height
        var wantToExpand: ((_ want: Bool)->())?
        lazy var threeDotView:UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 5
            for _ in 1...3{
                let dotView = UIView()
                dotView.backgroundColor = UIColor.colorFromHex("FCFCFB")
                dotView.layer.cornerRadius = 1.5
                stackView.addArrangedSubview(dotView)
            }
            return stackView
        }()
        lazy var destnationTitle:UILabel = {
            let label = UILabel()
           
            label.text = NTMetroStaticDatas.finalStationOfficalChinesName.紅樹林站.rawValue
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.numberOfLines = 2
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.colorFromHex("FCFCFB").cgColor
            label.backgroundColor = NTMetroStaticDatas.colors.redLine
            label.clipsToBounds = true
            label.layer.cornerRadius = 20
            return label
        }()
        required override init(frame: CGRect) {
            super.init(frame: .zero)
            self.settingThisView()
            self.addThisSubViews()
            self.layoutThisSubViews()
        }
        private func settingThisView(){
            self.layer.opacity = 0.8
            roundCorners(corners: [.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 20)
            backgroundColor = NTMetroStaticDatas.colors.darkModeOringnalUIBackground
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NarrowedNavigationButton.swipe))
            rightSwipe.direction = .right
            addGestureRecognizer(rightSwipe)
        }
        private func addThisSubViews(){
            addSubview(threeDotView)
            addSubview(destnationTitle)
        }
        private func layoutThisSubViews(){
            threeDotView.snp.makeConstraints({make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-5)
                make.height.equalTo(40)
                make.width.equalTo(3)
            })
            destnationTitle.snp.makeConstraints({make in
                make.bottom.trailing.equalToSuperview().offset(-15)
    //            make.trailing.equalTo(threeDotView.snp.leading).offset(-5)
                make.top.leading.equalToSuperview().offset(15)
                
            })
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        @objc private func swipe() {
            guard let wantToExpand = self.wantToExpand  else {return}
            wantToExpand(true)
       }
    }
}


