//
//  SnapKit+Extension.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/29.
//

import Foundation
import SnapKit
extension SnapKit.ConstraintMaker{
    func leadingXtrailingEqualToSuperview(offset:Float) {
        self.leading.equalToSuperview().offset(offset)
        self.trailing.equalToSuperview().offset(-offset)
    }
    func topXbottomEqualToSuperview(offset:Float) {
        self.top.equalToSuperview().offset(offset)
        self.bottom.equalToSuperview().offset(-offset)
    }
    func sameAsSuperView(){
        self.top.leading.bottom.trailing.equalToSuperview()
    }
}
