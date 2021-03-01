//
//  ExpadedNavigationView.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
extension DestinationInfoBoardView{
    enum WitchLineToEnd {
        case redLine,colorsLine
    }
    enum WitchColorLineToFront {
        case blueLine,greenLine
    }
    class ExpadedNavigationView: UIButton {
        let disposeBag = DisposeBag()
        
       
        let stateChanging = PublishSubject<(isRedLineEnd: Bool, witchColorLineToFront:WitchColorLineToFront)>()
        var swip:(()->())?
        private var isRedLineEnd = true{
            didSet{
                
            }
        }
        private var witchColorLineToFront:WitchColorLineToFront = .greenLine{
            didSet{
//                stateChanging.onNext((false,witchColorLineToFront))
            }
        }
        
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
        lazy var redView:RedLineView = {
            let view = RedLineView(frame: .zero)
            
            return view
        }()
        lazy var blueView:ColorsLineView = {
            let view = ColorsLineView(backgroundColor: NTMetroStaticDatas.colors.blueLine)
            view.title.text = NTMetroStaticDatas.finalStationOfficalChinesName.漁人碼頭.rawValue
            return view
        }()
        lazy var greenView:ColorsLineView = {
            let view = ColorsLineView(backgroundColor: NTMetroStaticDatas.colors.greenLine)
            view.title.text = NTMetroStaticDatas.finalStationOfficalChinesName.崁頂.rawValue
                
            return view
        }()
        private func animateBlueLineViewInFront(){
            greenView.snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(20)

            }
            blueView.snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(40)
            }
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                self?.layoutIfNeeded()
                
            },completion: {[unowned self ] _ in
                self.bringSubviewToFront(blueView)
                self.bringSubviewToFront(reverseButton)
            })
        }
        private func animateGreenLineViewInFront(){
            greenView.snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(40)
            }
            blueView.snp.updateConstraints { (make) in
                make.leadingXtrailingEqualToSuperview(offset: 20)
            }
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                self?.layoutIfNeeded()
                
            },completion: {[unowned self ] _ in
                self.bringSubviewToFront(greenView)
                self.bringSubviewToFront(reverseButton)

            })
        }
        lazy var reverseButton:ReverseButton = {
            func reverseAnimation(offset:Float){
                let rotateAnimation = CABasicAnimation.init(keyPath:"transform.rotation.z" )
                rotateAnimation.fromValue = 0
                rotateAnimation.toValue = 3
                rotateAnimation.repeatCount = 1
                
                self.reverseButton.layer.add(rotateAnimation, forKey: "transform.rotation.z")
                self.redView.snp.updateConstraints { (make) in
                    make.centerY.equalToSuperview().offset(offset)
                }
                self.blueView.snp.updateConstraints { (make) in
                    make.centerY.equalToSuperview().offset(-offset)
                }
                self.greenView.snp.updateConstraints { (make) in
                    make.centerY.equalToSuperview().offset(-offset)
                }
                UIView.animate(withDuration: 0.3, animations: {[weak self] in
                    self?.layoutIfNeeded()
                    
                })
            }
            let theButton = ReverseButton(side: 40)
            theButton.rx.tap.asObservable().map { (_) -> Bool in
                return false
            }
            .do(onNext: { [unowned self](_) in
                self.isRedLineEnd = !self.isRedLineEnd
                reverseAnimation(offset: self.isRedLineEnd ? -25:25)
                self.redView.departureTitle.text = self.redView.departureTitle.text == "終點" ? "起點":"終點"
                self.blueView.depatureTitle.text = self.redView.departureTitle.text == "起點" ? "終點":"起點"
                self.greenView.depatureTitle.text = self.redView.departureTitle.text == "起點" ? "終點":"起點"

                self.stateChanging.onNext((self.isRedLineEnd,self.witchColorLineToFront))

            })
            .bind(to: theButton.rx.isSelected)
            .disposed(by: disposeBag)
           
            
            return theButton
        }()
        required override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.settingThisView()
            self.addThisSubViews()
            self.subscribeThisViews()
            self.layoutThisSubViews()
        }
        private func settingThisView(){
            backgroundColor = NTMetroStaticDatas.colors.darkModeOringnalUIBackground
            roundCorners(corners: [.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 20)
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ExpadedNavigationView.swipe))
            leftSwipe.direction = .left
            addGestureRecognizer(leftSwipe)
          
        }
        private func addThisSubViews(){
            addSubview(threeDotView)
            addSubview(redView)
            addSubview(blueView)
            addSubview(greenView)
            
            addSubview(reverseButton)
        }
        private func subscribeThisViews(){
            greenView.trainLineSwitch.rx.isOn.asObservable().skip(1)
                .subscribe(onNext: {[unowned self ]  in
                    if $0{
                        

                    }else{
                        self.animateBlueLineViewInFront()
                        self.blueView.trainLineSwitch.isOn = false
                        self.witchColorLineToFront = .blueLine
                        self.stateChanging.onNext((self.isRedLineEnd,.blueLine))
                    }
                }).disposed(by: disposeBag)
            blueView.trainLineSwitch.rx.isOn.asObservable().skip(1)
                .subscribe(onNext: {[unowned self ]  in
                    if $0{
                        self.animateGreenLineViewInFront()
                        self.greenView.trainLineSwitch.isOn = true
                        self.witchColorLineToFront = .greenLine
                        self.stateChanging.onNext((self.isRedLineEnd,.greenLine))

                    }else{
        
                    }
                }).disposed(by: disposeBag)
            
        }
        private func layoutThisSubViews(){
            threeDotView.snp.makeConstraints({make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-5)
                make.height.equalTo(40)
                make.width.equalTo(3)
            })
            reverseButton
                .snp.makeConstraints({make in
                    make.centerY.equalToSuperview()
                    make.trailing.equalTo(threeDotView.snp.leading).offset(-30)
                    make.width.height.equalTo(reverseButton.side)
                })
            redView.snp.makeConstraints({make in
                make.leadingXtrailingEqualToSuperview(offset: 20)
                make.centerY.equalToSuperview().offset(-25)
                make.centerX.equalToSuperview()
                make.height.equalTo(45)
                
            })
            blueView.snp.makeConstraints({make in
                make.leadingXtrailingEqualToSuperview(offset: 20)
                make.centerY.equalToSuperview().offset(25)
                make.height.equalTo(45)
                
            })
            greenView
                .snp.makeConstraints({make in
                    make.trailing.equalToSuperview().offset(-20)
                    make.leading.equalToSuperview().offset(40)
                    make.centerY.equalToSuperview().offset(25)
                    make.height.equalTo(45)
                    
                    
                    
                })
        }
         @objc private func swipe() {
            guard  let swip = self.swip  else {return}
            swip()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
}

extension DestinationInfoBoardView.ExpadedNavigationView{
    class RedLineView: UIView {
        @IBOutlet weak var departureTitle: UILabel!
        static let nibName = String(describing: RedLineView.self)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            loadViewFromNib()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()
        }
        
        private func loadViewFromNib() {
            let view =  Bundle.main.loadNibNamed(RedLineView.nibName, owner: self, options: nil)?.first as! UIView
            view.frame = bounds;
            addSubview(view)
        }
    }
    class ColorsLineView: UIView {
        @IBOutlet weak var title: UILabel!
        @IBOutlet weak var depatureTitle: UILabel!
        let disposeBag = DisposeBag()
        @IBOutlet weak var trainLineSwitch: UISwitch!
        static let nibName = String(describing: ColorsLineView.self)
        
        convenience init(backgroundColor:UIColor) {
            self.init(frame: .zero)
            self.backgroundColor = backgroundColor
            settingThisView()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            loadViewFromNib()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            loadViewFromNib()
        }
        private func settingThisView(){
            layer.cornerRadius = 22
            if backgroundColor == NTMetroStaticDatas.colors.greenLine {
                trainLineSwitch.setOn(true, animated: false)
            }else{
                trainLineSwitch.setOn(false, animated: false)
                
            }
            
        }
        private func loadViewFromNib() {
            let view =  Bundle.main.loadNibNamed(ColorsLineView.nibName, owner: self, options: nil)?.first as! UIView
            view.frame = bounds;
            addSubview(view)
        }
    }
    class ReverseButton: UIButton {
        var side:CGFloat
        
        convenience init(side:CGFloat){
            self.init(frame: .zero)
            self.side = side
            layer.cornerRadius = side/2
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 0.3
            backgroundColor = NTMetroStaticDatas.colors.darkModeOringnalUIBackground
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .medium)
            setImage(UIImage(systemName: "arrow.up.arrow.down.circle",withConfiguration: largeConfig), for: .normal)
            
        }
        override init(frame: CGRect) {
            self.side = 0.0
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
