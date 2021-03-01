//
//  NTMetroViewModel.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/20.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NTMetroViewModel{
    let livingDepartureManager:LivingDepartureManager
    private(set) var startStation = NTMetroStaticDatas.stationColorType.green
    private(set) var endStation = NTMetroStaticDatas.stationColorType.red
    private(set) var depatureTimes:[String:String] =  [String:String]()
    private(set) var tableViewCellHeight = SettingUserDefaultManager.firstMetroLineLength
    var stationNames:[String]{
        
        switch (endStation,startStation) {
        
        case (.red,.green):
            return NTMetroStaticDatas.greenLineAbbreviationChinesNames
        case (.red,.blue):
            return NTMetroStaticDatas.blueLineAbbreviationChinesNames
        case (.blue,.red):
            return NTMetroStaticDatas.blueLineAbbreviationChinesNames.reversed()
        case (.green,.red):
            return NTMetroStaticDatas.greenLineAbbreviationChinesNames.reversed()
        default:return [String]()
        }
    }
     init(livingDepartureManager:LivingDepartureManager) {
        self.livingDepartureManager = livingDepartureManager
    }
    
    func updateSettingUserDefaultDatas() {
        tableViewCellHeight = SettingUserDefaultManager.share.metroLineLength
    }
    func setStartStation(stationColorType:NTMetroStaticDatas.stationColorType) {
        startStation = stationColorType
    }
    func setEndStation(stationColorType:NTMetroStaticDatas.stationColorType) {
        endStation = stationColorType
    }
    func setDepatureTime() {
        
        
        switch (endStation,startStation) {
        
        case (.red,.green):
            depatureTimes = livingDepartureManager.parse.allForwardToHongshulinTimes
        case (.red,.blue):
            
            depatureTimes = livingDepartureManager.parse.allForwardToHongshulinTimes
            
        case (.blue,.red):
            depatureTimes = livingDepartureManager.parse.allLeavingHongshulinTimes
        case (.green,.red):
            depatureTimes = livingDepartureManager.parse.allLeavingHongshulinTimes
        default:break
        }
    }
    func requestLivingDepartureManagerData() {
        livingDepartureManager.requset()
    }
   
}
