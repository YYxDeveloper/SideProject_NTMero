//
//  SettingUserDefaultManager.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/19.
//

import Foundation
import UIKit
class SettingUserDefaultManager{
    enum key:String {
        case isNTMetroViewControllerLeft,metroLineLength,isFirstSetting,selectedSegmentIndex
    }
    static let share = SettingUserDefaultManager()
    private(set) var ownedForwardToHongshulinTimes = [String:String]()
    private(set) var ownedLeavingHongshulinTimes = [String:String]()
     var isNTMetroViewControllerLeft:Bool{
        return UserDefaults.standard.bool(forKey: key.isNTMetroViewControllerLeft.rawValue)
    }
    var metroLineLength:Int{
        if UserDefaults.standard.integer(forKey: key.metroLineLength.rawValue) == 0 {
            return SettingUserDefaultManager.firstMetroLineLength
        }else{
            return UserDefaults.standard.integer(forKey: key.metroLineLength.rawValue)
        }
        
    }
    static let firstMetroLineLength = 80
    var selectedSegmentIndex:Int{return UserDefaults.standard.integer(forKey: key.selectedSegmentIndex.rawValue)}
    var isfirstSetting:String{return UserDefaults.standard.string(forKey: key.isFirstSetting.rawValue) ?? ""}

    func setTabItemsSorting(isNTMetroViewControllerLeft:Bool){
        UserDefaults.standard.setValue(isNTMetroViewControllerLeft, forKey: key.isNTMetroViewControllerLeft.rawValue)
        sync()
    }
    func setMetroLineLength(lineLengthLevel:Int) {
        if lineLengthLevel == 1 {
            UserDefaults.standard.setValue(SettingUserDefaultManager.firstMetroLineLength, forKey: key.metroLineLength.rawValue)

        }else{
            UserDefaults.standard.setValue(lineLengthLevel*50, forKey: key.metroLineLength.rawValue)

        }
        UserDefaults.standard.setValue(lineLengthLevel-1, forKey: key.selectedSegmentIndex.rawValue)
        sync()
    }
    func setFirstRegister() {
        UserDefaults.standard.setValue(true, forKey: key.isNTMetroViewControllerLeft.rawValue)
        UserDefaults.standard.setValue(SettingUserDefaultManager.firstMetroLineLength, forKey: key.metroLineLength.rawValue)
        UserDefaults.standard.setValue(key.isFirstSetting.rawValue, forKey: key.isFirstSetting.rawValue)
        sync()
    }
    func sync() {
        UserDefaults.standard.synchronize()
    }
}
