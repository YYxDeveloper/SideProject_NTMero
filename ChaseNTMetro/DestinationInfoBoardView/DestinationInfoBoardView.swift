//
//  DestinationInfoBoardView.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/29.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
class DestinationInfoBoardView: UIView {
    let disposeBag = DisposeBag()
    enum state {
        case narrow,expand
    }
    private(set) var state:DestinationInfoBoardView.state = .expand
    static let height:CGFloat = 115

    let expadedNavigationView = ExpadedNavigationView(frame: .zero)
    let narrowedNavigationButton = NarrowedNavigationButton(frame: .zero)
    let grayAnimationMaskView:UIView = {
        let view = UIView()
        view.backgroundColor = NTMetroStaticDatas.colors.darkModeOringnalUIBackground
        view.roundCorners(corners: [.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 20)

        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.settingSubViews()
        self.addThisSubViews()
        self.layoutThisSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func settingSubViews(){
        self.expadedNavigationView.stateChanging.subscribe({[unowned self] event in
            guard let destnationInfo = event.element  else {return}
            switch (destnationInfo.isRedLineEnd,destnationInfo.witchColorLineToFront) {
            case (true, _):
                narrowedNavigationButton.destnationTitle.backgroundColor = NTMetroStaticDatas.colors.redLine
                narrowedNavigationButton.destnationTitle.text = NTMetroStaticDatas.finalStationOfficalChinesName.紅樹林站.rawValue
            case (_,.blueLine):
                narrowedNavigationButton.destnationTitle.backgroundColor = NTMetroStaticDatas.colors.blueLine
                narrowedNavigationButton.destnationTitle.text = NTMetroStaticDatas.finalStationOfficalChinesName.漁人碼頭.rawValue

            case (_,.greenLine):
                narrowedNavigationButton.destnationTitle.backgroundColor = NTMetroStaticDatas.colors.greenLine
                narrowedNavigationButton.destnationTitle.text = NTMetroStaticDatas.finalStationOfficalChinesName.崁頂.rawValue


            }
            
        }).disposed(by: disposeBag)
        self.expadedNavigationView.swip = {[unowned self] in
            self.setState(state: .narrow)
        }
        self.narrowedNavigationButton.rx.tap.subscribe({[unowned self] _ in
            self.setState(state: .expand)
        }).disposed(by: disposeBag)
        self.narrowedNavigationButton.wantToExpand = {[unowned self] wantToExpand in
            self.setState(state: .expand)
        }
    }
    private func addThisSubViews(){
        self.addSubview(grayAnimationMaskView)
        self.addSubview(narrowedNavigationButton)
        self.addSubview(expadedNavigationView)

    }
    private func layoutThisSubViews(){
        grayAnimationMaskView.snp.makeConstraints({make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview()
        })
        expadedNavigationView.snp.makeConstraints({make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview()
        })
            
        narrowedNavigationButton.snp.makeConstraints({make in
            make.height.equalTo(DestinationInfoBoardView.NarrowedNavigationButton.heigt)
            make.width.equalToSuperview().dividedBy(3)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        })
    }
    private func refreshSubViews(){
        if self.state == .expand {
         
            
            animateExpandModel()
        }else{
            animateNarrowModel()
        }
    }
    private func animateNarrowModel(){
        expadedNavigationView.isHidden = true
        grayAnimationMaskView.isHidden = false
        narrowedNavigationButton.isHidden = true

        grayAnimationMaskView.snp.remakeConstraints({make in
            make.height.equalTo(DestinationInfoBoardView.NarrowedNavigationButton.heigt)
            make.width.equalToSuperview().dividedBy(3)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        UIView.animate(withDuration: 0.3, animations: {[unowned self]  in
            self.layoutIfNeeded()
        }, completion: {[unowned self] _ in
            grayAnimationMaskView.isHidden = true
            narrowedNavigationButton.isHidden = false
            

        })
    }
    private func animateExpandModel(){
        expadedNavigationView.isHidden = true
        grayAnimationMaskView.isHidden = false
        narrowedNavigationButton.isHidden = true
        grayAnimationMaskView.snp.remakeConstraints({make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview()
        })
        UIView.animate(withDuration: 0.3, animations: {[unowned self]  in
            self.layoutIfNeeded()
        }, completion: {[unowned self] _ in
            grayAnimationMaskView.isHidden = true
            expadedNavigationView.isHidden = false


        })
    }
}
extension DestinationInfoBoardView{
    //open method

    func setState(state:DestinationInfoBoardView.state) {
         self.state = state
        refreshSubViews()
    }
}
