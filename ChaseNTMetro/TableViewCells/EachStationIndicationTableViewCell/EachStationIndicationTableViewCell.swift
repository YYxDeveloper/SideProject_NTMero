//
//  EachStationIndicationTableViewCell.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/2/3.
//

import Foundation
import UIKit
protocol ThisViewRules {
    func settingThisViews()
    func addThisViews()
    func layoutThisViews()
    func settingRxSubScribe()
    
}
class EachStationIndicationTableViewCell: UITableViewCell {
    let view = EachStationIndicationView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        settingThisViews()
        addThisViews()
        layoutThisViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
// MARK: - Open Func -
extension EachStationIndicationTableViewCell{
    //viewModel.startStation,viewModel.endStation
    func refreshViewState( start:NTMetroStaticDatas.stationColorType, end:NTMetroStaticDatas.stationColorType){
        switch(start,end){
        case (.red,.blue):
            view.changeStateAttribution(lineColor: NTMetroStaticDatas.colors.blueLine, arrowDirection: .down)
        case (.blue,.red):
            view.changeStateAttribution(lineColor: NTMetroStaticDatas.colors.redLine, arrowDirection: .up)
        case (.red,.green):
            view.changeStateAttribution(lineColor: NTMetroStaticDatas.colors.greenLine, arrowDirection: .down)
        case (.green,.red):
            view.changeStateAttribution(lineColor: NTMetroStaticDatas.colors.redLine, arrowDirection: .up)
        default: break
        }
    }
}
extension EachStationIndicationTableViewCell:ThisViewRules{
    func settingRxSubScribe() {
        
    }
    
    func settingThisViews() {
        settingRxSubScribe()
    }
    
    func addThisViews() {
        contentView.addSubview(view)
    }
    
    func layoutThisViews() {
        view.snp.makeConstraints({make in make.sameAsSuperView()})
            
            
        
    }
    
    
}

