//
//  NTMetroViewController.swift
//  YYxUIUXProvingGround
//
//  Created by 呂子揚 on 2021/1/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa



class NTMetroViewController: UIViewController {
    
    let viewModel:NTMetroViewModel
    let disposeBag = DisposeBag()

    // MARK: - Views
//    lazy var bannerView: GADBannerView = {
//        let   bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//         bannerView.rootViewController = self
//        return  bannerView
//        
//    }()
    lazy var tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
//        let adview = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
//        adview.addSubview(self.bannerView)
//        bannerView.snp.makeConstraints({make in make.sameAsSuperView() })
//        bannerView.load(GADRequest())
//        table.tableHeaderView = adview

        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: DestinationInfoBoardView.height, right: 0)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = NTMetroStaticDatas.colors.mainBackgroundColor
        return table
    }()
    
    let destinationInfoBoardView = DestinationInfoBoardView(frame: .zero)
    init(livingDepartureManager:LivingDepartureManager) {
        self.viewModel = NTMetroViewModel(livingDepartureManager: livingDepartureManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        stettingThisView()
        addThisSubViews()
        layoutThisView()
        subscribe()
        viewModel.requestLivingDepartureManagerData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.refreshThisSubViewsFromSetting()
    }
    private func subscribe() {
        
        viewModel.livingDepartureManager.parse.subjects.forward.subscribe({[unowned self] subject in
            DispatchQueue.main.async {
                
                switch (viewModel.endStation,viewModel.startStation) {
                case (.red,.green),(.red,.blue):
                    viewModel.setDepatureTime()
                    self.tableView.reloadData()
                default:break
                }
                
                
                
            }
        }).disposed(by: disposeBag)
        viewModel.livingDepartureManager.parse.subjects.leaving.subscribe({[unowned self] subject in
            DispatchQueue.main.async {
                switch (viewModel.endStation,viewModel.startStation) {
                case (.blue,.red),(.green,.red):
                    viewModel.setDepatureTime()
                    self.tableView.reloadData()
                default:break
                }
                
            }
        }).disposed(by: disposeBag)
    }
    private func stettingThisView(){
        if self.traitCollection.userInterfaceStyle == .dark {
                    // User Interface is Dark
                view.backgroundColor = .black
                } else {
                    // User Interface is Light
                    view.backgroundColor = .white

                }
        destinationInfoBoardView.expadedNavigationView.stateChanging.subscribe({[unowned self] subject in
            guard  let states = subject.element else {return}
            switch(states.isRedLineEnd,states.witchColorLineToFront){
            case (true,.blueLine):
                viewModel.setStartStation(stationColorType: .blue)
                viewModel.setEndStation(stationColorType: .red)
                self.viewModel.setStartStation(stationColorType: .blue)
//                self.tableView.reloadData()
            case (false,.blueLine):
                viewModel.setEndStation(stationColorType: .blue)
                viewModel.setStartStation(stationColorType: .red)
                
            case (true,.greenLine):
                viewModel.setStartStation(stationColorType: .green)
                viewModel.setEndStation(stationColorType: .red)
                self.viewModel.setStartStation(stationColorType: .green)
//                self.tableView.reloadData()
                
            case (false,.greenLine):
                viewModel.setEndStation(stationColorType: .green)
                viewModel.setStartStation(stationColorType: .red)
            }
            self.viewModel.requestLivingDepartureManagerData()

            
        }).disposed(by: disposeBag)
        
    }
    private func addThisSubViews(){
        view.addSubview(tableView)
        view.addSubview(destinationInfoBoardView)
    }
    private func layoutThisView(){
        guard  let tabBar = tabBarController?.tabBar else {return}
        tableView.snp.makeConstraints({make in
            make.leadingXtrailingEqualToSuperview(offset: 0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().offset(-tabBar.frame.height)
            
            
        })
        
        destinationInfoBoardView.snp.makeConstraints({make in
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset( -5)
            make.height.equalTo(DestinationInfoBoardView.height)
            make.trailing.equalToSuperview().offset(-50)
            
        })
        
    }
    func refreshThisSubViewsFromSetting() {
        viewModel.updateSettingUserDefaultDatas()
        tableView.reloadData()
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
