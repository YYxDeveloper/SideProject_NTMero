//
//  NTMetroStaticDatas.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/18.
//

import Foundation
import UIKit

class NTMetroStaticDatas {
    // MARK: - values
    static let fifteen = 15
    static let fifty = 50
    
    static let cornerRadius = fifteen
    static let squrdButtonLength = fifty
    
    enum fontSize: CGFloat{
        case bigest = 35,big = 30,normal = 25, small = 18
    }
    enum witchCase:String{
        case 紅樹林,
             竿蓁林,
             淡金鄧公,
             淡江大學,
             淡金北新,
             新市一路,
             行政中心,
             濱海義山,
             濱海沙崙
        case 海洋科大,
             沙崙,
             漁人碼頭
        case 淡海新市鎮,
             崁頂
    }
    enum stationColorType{
        case red,blue,green
    }
    enum finalStationOfficalChinesName:String,CaseIterable {
        case 紅樹林站,漁人碼頭,崁頂
        
    }
    static let greenToHongshulinStatioOfficialnNames:[String] = {
        NTMetroStaticDatas.greenLineStationInfo.officalChinesName.allCases.map({$0.rawValue}) + NTMetroStaticDatas.redLineStationInfo.officalChinesName.allCases.map({$0.rawValue})
    }()
    static let blueToHongshulinStationOfficialNames:[String] = {
        NTMetroStaticDatas.blueLineStationInfo.officalChinesName.allCases.map({$0.rawValue}) + NTMetroStaticDatas.redLineStationInfo.officalChinesName.allCases.map({$0.rawValue})
    }()
    static let greenLineAbbreviationChinesNames:[String] = {
        let redStations = redLineStationInfo.abbreviationChiName.allCases
            .map({ "\($0)" })
        
        let greenStations = greenLineStationInfo.abbreviationChiName.allCases
            .map({ "\($0)" })
        
        return redStations + greenStations
    }()
    static let greenLineEngNames:[String] = {
        let redStations = redLineStationInfo.stationEngName.allCases
            .map({ "\($0)" })
        
        let greenStations = greenLineStationInfo.stationEngName.allCases
            .map({ "\($0)" })
        return redStations + greenStations
    }()
    static let blueLineAbbreviationChinesNames:[String] = {
        let redStations = redLineStationInfo.abbreviationChiName.allCases
            .map({ "\($0)" })
        
        let blueStations = blueLineStationInfo.abbreviationChiName.allCases
            .map({ "\($0)" })

        return redStations + blueStations
    }()
    static let blueLineEngNames:[String] = {
        let redStations = redLineStationInfo.stationEngName.allCases
            .map({ "\($0)" })
        
        let blueStations = blueLineStationInfo.stationEngName.allCases
            .map({ "\($0)" })
        
        return redStations + blueStations
    }()
    enum greenLineStationInfo {
        enum officalChinesName:String,CaseIterable {
            case 淡海新市鎮 = "淡海新市鎮站(V10)",
                 崁頂 = "崁頂站(V11)"
        }
        enum abbreviationChiName:String,CaseIterable {
            case 淡海新市鎮,
                 崁頂
            
        }
        enum stationEngName:String,CaseIterable {
            case 淡海新市鎮 = "Danhai New Town",
                 崁頂 = "Kanding"
            
        }
    }
    enum blueLineStationInfo {
        enum officalChinesName:String,CaseIterable {
            case 海洋科大 = "海洋科大站(V28)",
                 沙崙 = "沙崙站(V27)",
                 漁人碼頭 = "漁人碼頭站(V26)"
        }
        enum abbreviationChiName:String,CaseIterable {
            case 海洋科大,
                 沙崙,
                 漁人碼頭
        }
        enum stationEngName:String,CaseIterable {
            case 海洋科大 = "Taipei University of Marine Technology",
                 沙崙 = "Shalun",
                 漁人碼頭 = "Fisherman's Wharf"
        }
    }
    enum redLineStationInfo {
        enum officalChinesName:String,CaseIterable {
            case 紅樹林 = "紅樹林站(V01)",
                 竿蓁林 = "竿蓁林站(V02)",
                 淡金鄧公 = "淡金鄧公站(V03)",
                 淡江大學 = "淡江大學站(V04)",
                 淡金北新 = "淡金北新站(V05)",
                 新市一路 = "新市一路站(V06)",
                 行政中心 = "淡水行政中心站(V07)",
                 濱海義山 = "濱海義山站(V08)",
                 濱海沙崙 = "濱海沙崙站(V09)"
        }
        enum abbreviationChiName:String,CaseIterable {
            case 紅樹林,
                 竿蓁林,
                 淡金鄧公,
                 淡江大學,
                 淡金北新,
                 新市一路,
                 行政中心,
                 濱海義山,
                 濱海沙崙
        }
        enum stationEngName:String,CaseIterable {
            case 紅樹林 = "Hongshulin",
                 竿蓁林 = "Ganzhenlin",
                 淡金鄧公 = "Danjin Denggong",
                 淡江大學 = "Tabkang University",
                 淡金北新 = "Danjin Beixin",
                 新市一路 = "Xinshi 1st Rd.",
                 行政中心 = "District Office",
                 濱海義山 = "Binhai Yishan",
                 濱海沙崙 = "Binhai Shalun"
        }
        
        
    }
    struct colors {
        static let redLine = UIColor.colorFromHex("EB6C5D")
        static let blueLine = UIColor.colorFromHex("3B8AC9")
        static let greenLine = UIColor.colorFromHex("61BD68")
        static let darkModeOringnalUIBackground = UIColor.colorFromHex("B3B2B2")
        static let mainBackgroundColor = UIColor.colorFromHex("686768")
        
        
        
    }

    static func getWitchStationTexts(witchCase:NTMetroStaticDatas.witchCase) -> ((abbreviationChiName:String,officalChinesName:String,stationEngName:String)){

        switch witchCase.rawValue {
        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.紅樹林.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.紅樹林.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.紅樹林.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.紅樹林.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.竿蓁林.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.竿蓁林.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.竿蓁林.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.竿蓁林.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.濱海義山.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.濱海義山.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.濱海義山.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.濱海義山.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.濱海沙崙.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.濱海沙崙.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.濱海沙崙.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.濱海沙崙.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.淡金鄧公.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.淡金鄧公.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.淡金鄧公.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.淡金鄧公.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.淡金北新.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.淡金北新.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.淡金北新.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.淡金北新.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.淡江大學.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.淡江大學.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.淡江大學.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.淡江大學.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.行政中心.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.行政中心.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.行政中心.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.行政中心.rawValue)

        case NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.新市一路.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.redLineStationInfo.abbreviationChiName.新市一路.rawValue,officalChinesName:NTMetroStaticDatas.redLineStationInfo.officalChinesName.新市一路.rawValue,stationEngName:NTMetroStaticDatas.redLineStationInfo.stationEngName.新市一路.rawValue)


        // blue line
        case NTMetroStaticDatas.blueLineStationInfo.abbreviationChiName.沙崙.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.blueLineStationInfo.abbreviationChiName.沙崙.rawValue,officalChinesName:NTMetroStaticDatas.blueLineStationInfo.officalChinesName.沙崙.rawValue,stationEngName:NTMetroStaticDatas.blueLineStationInfo.stationEngName.沙崙.rawValue)

        case NTMetroStaticDatas.blueLineStationInfo.abbreviationChiName.海洋科大.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.blueLineStationInfo.abbreviationChiName.海洋科大.rawValue,officalChinesName:NTMetroStaticDatas.blueLineStationInfo.officalChinesName.海洋科大.rawValue,stationEngName:NTMetroStaticDatas.blueLineStationInfo.stationEngName.海洋科大.rawValue)

        case NTMetroStaticDatas.blueLineStationInfo.abbreviationChiName.漁人碼頭.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.blueLineStationInfo.abbreviationChiName.漁人碼頭.rawValue,officalChinesName:NTMetroStaticDatas.blueLineStationInfo.officalChinesName.漁人碼頭.rawValue,stationEngName:NTMetroStaticDatas.blueLineStationInfo.stationEngName.漁人碼頭.rawValue)

        // green line
        case NTMetroStaticDatas.greenLineStationInfo.abbreviationChiName.崁頂.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.greenLineStationInfo.abbreviationChiName.崁頂.rawValue,officalChinesName:NTMetroStaticDatas.greenLineStationInfo.officalChinesName.崁頂.rawValue,stationEngName:NTMetroStaticDatas.greenLineStationInfo.stationEngName.崁頂.rawValue)

        case NTMetroStaticDatas.greenLineStationInfo.abbreviationChiName.淡海新市鎮.rawValue:
            return (abbreviationChiName:NTMetroStaticDatas.greenLineStationInfo.abbreviationChiName.淡海新市鎮.rawValue,officalChinesName:NTMetroStaticDatas.greenLineStationInfo.officalChinesName.淡海新市鎮.rawValue,stationEngName:NTMetroStaticDatas.greenLineStationInfo.stationEngName.淡海新市鎮.rawValue)

        
        default:
            return (abbreviationChiName:NTMetroStaticDatas.blueLineStationInfo.abbreviationChiName.漁人碼頭.rawValue,officalChinesName:NTMetroStaticDatas.blueLineStationInfo.officalChinesName.漁人碼頭.rawValue,stationEngName:NTMetroStaticDatas.blueLineStationInfo.stationEngName.漁人碼頭.rawValue)

        }

    }

}
