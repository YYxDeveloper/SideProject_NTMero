//
//  TableViewDelegate+NTMetroViewController.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
extension NTMetroViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stationNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EachStationIndicationTableViewCell") as? EachStationIndicationTableViewCell  {
            cell.view.stationName.text = viewModel.stationNames[indexPath.row]
            cell.refreshViewState(start: viewModel.startStation, end: viewModel.endStation)
            
            
            if let witchCase = NTMetroStaticDatas.witchCase(rawValue: viewModel.stationNames[indexPath.row]) {
                let key = NTMetroStaticDatas.getWitchStationTexts(witchCase: witchCase ).officalChinesName
                cell.view.departureLabel.text = viewModel.depatureTimes[key]
                cell.view.flagImageView.isHidden = viewModel.depatureTimes[key] == "即將進站" ? false:true
                
//                if viewModel.depatureTimes[key] == "即將進站" {
//                    
//                    UIView.animate(withDuration: 1, delay: 0.0, options:[.repeat, .autoreverse,.beginFromCurrentState], animations: {
//                        cell.view.xibVIew.backgroundColor = EachStationIndicationView.BackgroundColor.withAlphaComponent(0.3)
//                    }, completion:{ _ in
//                        cell.view.xibVIew.backgroundColor = EachStationIndicationView.BackgroundColor
//                    })
//                }else{
//                    cell.view.xibVIew.layer.removeAllAnimations()
//                    
//                }
            }
            
            
            
            return cell
        }else{
            let cell = EachStationIndicationTableViewCell(style: .default, reuseIdentifier: "EachStationIndicationTableViewCell")
            cell.view.stationName.text = viewModel.stationNames[indexPath.row]
            cell.backgroundColor = NTMetroStaticDatas.colors.mainBackgroundColor
            return cell
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.tableViewCellHeight)
    }
    
}
