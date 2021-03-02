//
//  LivingDepartureManager.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/14.
//

import Foundation
import Kanna
import RxSwift
import Alamofire
extension LivingDepartureManager{
    
    class Parse {
        private(set) var allForwardToHongshulinTimes = [String:String]()
        private(set) var allLeavingHongshulinTimes = [String:String]()

        var subjects = (forward:PublishSubject<[String:String]>(),leaving:PublishSubject<[String:String]>())
        private var htmlContent = String()
        func update(content html:String)  {
            htmlContent = html
            parseBlueToHongshulin(subwayUp: html)
            parseRedToHongshulin(subwayUp: html)
            parseGreenToHongshulin(subwayUp: html)
            subjects.forward.onNext(allForwardToHongshulinTimes)
            
            parseRedLeavingHongshulin(subwayDown: html)
            parseBlueLeavingHongshulin(subwayDown: html)
            parseGreenLeavingHongshulin(subwayDown: html)
            subjects.leaving.onNext(allLeavingHongshulinTimes)
            
        }
        private func parseRedLeavingHongshulin(subwayDown pathForResource:String){
            do {
                //                let content = (try? String(contentsOfFile: pathForResource, encoding: String.Encoding.utf8)) ?? String()
                
                let doc =  try Kanna.HTML(html: pathForResource, encoding: String.Encoding.utf8)
                //*[@id="subway_down"]/table/tbody/tr[7]/td[3]/div
                
                
                for (index,_) in NTMetroStaticDatas.redLineStationInfo.officalChinesName.allCases.enumerated() {
                    let docStationNamePath = #"//*[@id="subway_down"]/table/tbody/tr[\#(index+1)]/td[1]"#
                    let docDeparturePath = #"//*[@id="subway_down"]/table/tbody/tr[\#(index+1)]/td[3]/div"#
                    guard let docStationName = doc.xpath(docStationNamePath).map({$0.text}).first else {return}
                    let docDeparture  = doc.xpath(docDeparturePath).map({$0.text}).first ?? ""
                    
                    //                    print("\(docStationName!) >>> \(docDeparture!)")
                    allLeavingHongshulinTimes[docStationName!] = docDeparture!
                }
                //                print(allLeavingHongshulinTimes)
                
                
                
            }catch {
                print(error.localizedDescription)
            }
        }
        private func parseBlueLeavingHongshulin(subwayDown pathForResource:String){
            do {
                //                let content = (try? String(contentsOfFile: pathForResource, encoding: String.Encoding.utf8)) ?? String()
                
                let doc =  try Kanna.HTML(html: pathForResource, encoding: String.Encoding.utf8)
                
                
                
                for (index,_) in NTMetroStaticDatas.blueLineStationInfo.officalChinesName.allCases.enumerated() {
                    let docStationNamePath = #"//*[@id="subway_down"]/table/tbody/tr[\#(index+10)]/td[6]"#
                    let docDeparturePath = #"//*[@id="subway_down"]/table/tbody/tr[\#(index+10)]/td[4]/div"#
                    guard let docStationName = doc.xpath(docStationNamePath).map({$0.text}).first else {return}
                    let docDeparture  = doc.xpath(docDeparturePath).map({$0.text}).first ?? ""
                    
                    //                    print("\(docStationName!) >>> \(docDeparture!)")
                    allLeavingHongshulinTimes[docStationName!] = docDeparture!
                }
                //                print(allLeavingHongshulinTimes)
                
                
                
            }catch {
                print(error.localizedDescription)
            }
        }
        private func parseGreenLeavingHongshulin(subwayDown pathForResource:String){
            do {
                //                let content = (try? String(contentsOfFile: pathForResource, encoding: String.Encoding.utf8)) ?? String()
                
                let doc =  try Kanna.HTML(html: pathForResource, encoding: String.Encoding.utf8)
                
                
                
                for (index,_) in NTMetroStaticDatas.greenLineStationInfo.officalChinesName.allCases.enumerated() {
                    let docStationNamePath = #"//*[@id="subway_down"]/table/tbody/tr[\#(index+10)]/td[1]"#
                    let docDeparturePath = #"//*[@id="subway_down"]/table/tbody/tr[\#(index+10)]/td[3]/div"#
                    guard let docStationName = doc.xpath(docStationNamePath).map({$0.text}).first else {return}
                    let docDeparture  = doc.xpath(docDeparturePath).map({$0.text}).first ?? ""
                    
                    //                    print("\(docStationName!) >>> \(docDeparture!)")
                    allLeavingHongshulinTimes[docStationName!] = docDeparture!
                }
                
                
                
                
            }catch {
                print(error.localizedDescription)
            }
        }
        static func getTestHtmlContent() -> String{
            return Bundle.main.path(forResource: "LineDepartureTestHTML", ofType: "txt") ?? String()
        }
        private func parseRedToHongshulin(subwayUp pathForResource:String){
            do {
                //                let content = (try? String(contentsOfFile: pathForResource, encoding: String.Encoding.utf8)) ?? String()
                
                let doc =  try Kanna.HTML(html: pathForResource, encoding: String.Encoding.utf8)
                
                
                
                for (index,_) in NTMetroStaticDatas.redLineStationInfo.officalChinesName.allCases.enumerated() {
                    let docStationNamePath = #"//*[@id="subway_up"]/table/tbody/tr[\#(index + 4)]/td[1]"#
                    let docDeparturePath = #"//*[@id="subway_up"]/table/tbody/tr[\#(index + 4)]/td[3]/div"#
                    guard let docStationName = doc.xpath(docStationNamePath).map({$0.text}).first else {return}
                    let docDeparture  = doc.xpath(docDeparturePath).map({$0.text}).first ?? ""
                    
                    //                    print("\(docStationName!) >>> \(docDeparture!)")
                    allForwardToHongshulinTimes[docStationName!] = docDeparture!
                }
                //                print(redToHongshulinTimes)
                
                
                
            }catch {
                print(error.localizedDescription)
            }
        }
        private func parseBlueToHongshulin(subwayUp pathForResource:String) {
            do {
                //                let content = (try? String(contentsOfFile: pathForResource, encoding: String.Encoding.utf8)) ?? String()
                let doc =  try Kanna.HTML(html: pathForResource, encoding: String.Encoding.utf8)
                for (index,_) in NTMetroStaticDatas.blueLineStationInfo.officalChinesName.allCases.enumerated() {
                    let docStationNamePath = #"//*[@id="subway_up"]/table/tbody/tr[\#(index + 1)]/td[6]"#
                    let docDeparturePath = #"//*[@id="subway_up"]/table/tbody/tr[\#(index + 1)]/td[4]/div"#
                    guard let docStationName = doc.xpath(docStationNamePath).map({$0.text}).first else {return}
                    let docDeparture  = doc.xpath(docDeparturePath).map({$0.text}).first ?? ""
                    allForwardToHongshulinTimes[docStationName!] = docDeparture!
                    
                }
                
                //                print(blueToHongshulinTimes)
                
            }catch {
                print(error.localizedDescription)
            }
        }
        private func parseGreenToHongshulin(subwayUp pathForResource:String){
            do {
                //                let content = (try? String(contentsOfFile: pathForResource, encoding: String.Encoding.utf8)) ?? String()
                let doc =  try Kanna.HTML(html: pathForResource, encoding: String.Encoding.utf8)
                for (index,_) in NTMetroStaticDatas.greenLineStationInfo.officalChinesName.allCases.enumerated() {
                    let docStationNamePath = #"//*[@id="subway_up"]/table/tbody/tr[\#(index+2)]/td[1]"#
                    let docDeparturePath = #"//*[@id="subway_up"]/table/tbody/tr[\#(index+2)]/td[3]/div"#
                    guard let docStationName = doc.xpath(docStationNamePath).map({$0.text}).first else {return}
                    let docDeparture  = doc.xpath(docDeparturePath).map({$0.text}).first ?? ""
                    allForwardToHongshulinTimes[docStationName!] = docDeparture!
                    
                }
                //                print("11111\(allForwardToHongshulinTimes)")
                
                
            }catch {
                print(error.localizedDescription)
                
            }
        }
    }
}
class LivingDepartureManager {
    
    lazy var timer:Timer = {
        
        return  Timer.scheduledTimer(timeInterval: 15 , target: self, selector: #selector(alarmSitySecond), userInfo: nil, repeats: true)
        
    }()
    let parse = Parse()
    init() {
        //        parse.update(content: Parse.getTestHtmlContent())
    }
    enum NetworkError: Error {
        case url
        case server
        case timeout
    }
    @objc func alarmSitySecond() {
        requset()
        
    }
    func wakeTimer() {
        _=timer
    }
    func requset() {
        let path = "https://trainsmonitor.ntmetro.com.tw/"
        var result: Result<String?, NetworkError>!

        AF.request(path).response { response in
            
            
            if let data = response.data {
                result = .success(String(data: data, encoding: .utf8))
            } else {
                result = .failure(.server)
            }
            switch result {
            
            case .success(let content):
                
                guard  let content = content else {print("LivingDepartureManager request success, but empty content");return}
                self.parse.update(content: content)
                
            case .failure( let wrongMsg):
                print("wrongMsg:::\(wrongMsg)")
                
            case .none:
                break
            }
//            debugPrint(response)
            
        }
        
    
        
    }
    
    
}
