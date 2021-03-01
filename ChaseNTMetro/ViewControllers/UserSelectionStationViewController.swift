//
//  UserSelectionStationViewController.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/11.
//

import UIKit
import Foundation

extension UserSelectionStationViewController{
    class ViewModel {
        let livingDepartureManager:LivingDepartureManager
        init(livingDepartureManager:LivingDepartureManager) {
            self.livingDepartureManager = livingDepartureManager
        }
    }
}

class UserSelectionStationViewController: UIViewController{
    let viewModel:ViewModel
    init(livingDepartureManager:LivingDepartureManager) {
        self.viewModel = ViewModel(livingDepartureManager: livingDepartureManager)
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
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
