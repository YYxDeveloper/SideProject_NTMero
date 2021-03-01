//
//  SettingViewController.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/19.
//

import UIKit
import Foundation
extension SettingViewController{
    class ViewModel{
        var switchChanging: ((_ isOn: Bool)->())?
        var segChanging: ((_ index: Int)->())?
        
        
    }
}
class SettingViewController: UIViewController,YYxSubViewRules {
    let viewModel = ViewModel()
    
    lazy var tableView:UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.rowHeight = 45
        tb.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        tb.register(SettingSegmentTableViewCell.self, forCellReuseIdentifier: "SettingSegmentTableViewCell")
        tb.register(SettingSwitchTableViewCell.self, forCellReuseIdentifier: "SettingSwitchTableViewCell")
        tb.separatorInset  = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.isScrollEnabled = false
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NTMetroStaticDatas.colors.mainBackgroundColor
        setingThisSubViews()
        addThisSubViews()
        layoutThisSubViews()
    }
    
    func setingThisSubViews() {
        
    }
    
    func addThisSubViews() {
        view.addSubview(tableView)
    }
    
    func layoutThisSubViews() {
        tableView.snp.makeConstraints({make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(tableView.rowHeight * 3)
            
        })
    }
    func refreshThisSubViewsFromSetting() {
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension SettingViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            let vc = DeclarationViewController()
            navigationController?.pushViewController(vc, animated: true)
        case (_, _):break
            
        }
    }
    
    struct TableCellDatas{
        static let rightDeclare = (  imageName :"info.circle", title :"版權宣告")
        static let exchangeTabItemPosition = ( imageName :"arrow.left.arrow.right.circle", title :"頁面位置")
        static let metroLineLength = ( imageName :"ruler", title :"站點間隔")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell
            else {return UITableViewCell()}
            cell.setInformation(information: TableCellDatas.rightDeclare)
            return cell
        case (0,1):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingSegmentTableViewCell", for: indexPath) as? SettingSegmentTableViewCell
            else {return UITableViewCell()}
            cell.setInformation(information: TableCellDatas.metroLineLength)
            cell.segment.selectedSegmentIndex = SettingUserDefaultManager.share.selectedSegmentIndex
            
            cell.segChanging = {[unowned self] selectedIndex in
                guard let segChanging = self.viewModel.segChanging   else {return}
                segChanging(selectedIndex)
            }
            return cell
//        case (0,2):
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingSwitchTableViewCell", for: indexPath) as? SettingSwitchTableViewCell
//            else {return UITableViewCell()}
//            cell.setInformation(information: TableCellDatas.exchangeTabItemPosition)
//            cell.swItch.setOn(SettingUserDefaultManager.share.isNTMetroViewControllerLeft, animated: false)
//            cell.switchChanging = {[unowned self] isOn in
//                guard let switchChanging = self.viewModel.switchChanging   else {return}
//                switchChanging(isOn)
//            }
//            return cell
        case (_, _):
            return UITableViewCell()
        }
        
    }
    
    
    
}
