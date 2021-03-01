//
//  MainTabBarController.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/19.
//

import Foundation
import UIKit
import RxSwift
extension MainTabBarController{
    class ViewModel {
    }
}
class MainTabBarController: UITabBarController {
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    let livingDepartureManager = LivingDepartureManager()
    lazy var nTMetroViewController:NTMetroViewController = {
        let nTMetroViewController = NTMetroViewController(livingDepartureManager: livingDepartureManager)
        nTMetroViewController.tabBarItem.image = UIImage(systemName: "tram")
        nTMetroViewController.tabBarItem.title = "即時時刻"
        return nTMetroViewController
    }()
    lazy var userSelectionStationViewController:UserSelectionStationViewController = {
        let userSelectionStationViewController = UserSelectionStationViewController(livingDepartureManager: livingDepartureManager)
        userSelectionStationViewController.tabBarItem.image = UIImage(systemName: "heart")
        userSelectionStationViewController.tabBarItem.title = "常用清單"
        
        return userSelectionStationViewController
    }()
    lazy var settingViewController:SettingViewController = {
        let settingViewController = SettingViewController()
        settingViewController.tabBarItem.image = UIImage(systemName: "gear")
        settingViewController.tabBarItem.title = "設定"
        
        return settingViewController
    }()
    lazy var settingNavigationViewController:UINavigationController = {
        let settingNavigationViewController  = UINavigationController(rootViewController:settingViewController )
        return settingNavigationViewController
    }()

    override func viewDidLoad() {
       
        livingDepartureManager.wakeTimer()
        self.viewControllers = [nTMetroViewController,settingNavigationViewController]
        self.settingViewController.viewModel.segChanging = {[unowned self] index in
            self.nTMetroViewController.tableView.reloadData()
            
        }
//        modifyUserdefaultSetting()
//        handelSettingViewControllerCallback()
        
        
    }
    func modifyUserdefaultSetting(){
        if SettingUserDefaultManager.share.isfirstSetting == ""{
           
            
            SettingUserDefaultManager.share.setFirstRegister()
            self.viewControllers = [nTMetroViewController,userSelectionStationViewController,settingNavigationViewController]
            
        }
        if SettingUserDefaultManager.share.isNTMetroViewControllerLeft{
            self.viewControllers = [nTMetroViewController,userSelectionStationViewController,settingNavigationViewController]

        }else{
            self.viewControllers = [userSelectionStationViewController,nTMetroViewController,settingNavigationViewController]

        }
        
        nTMetroViewController.refreshThisSubViewsFromSetting()
        userSelectionStationViewController.refreshThisSubViewsFromSetting()
        settingViewController.refreshThisSubViewsFromSetting()
    }
    func handelSettingViewControllerCallback() {

        settingViewController.viewModel.switchChanging = {[unowned self] isOn in
            // default is off

                        if isOn{
                            self.viewControllers = [self.nTMetroViewController,self.userSelectionStationViewController,self.settingNavigationViewController]

                        }else{
                            self.viewControllers = [self.userSelectionStationViewController,self.nTMetroViewController,self.settingNavigationViewController]

                        }

        }
        self.settingViewController.viewModel.segChanging = {[unowned self] index in
            self.nTMetroViewController.tableView.reloadData()
            
        }
    }
    
    
}
