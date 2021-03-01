//
//  SettingTableViewCell.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/19.
//

import UIKit
class SettingSwitchTableViewCell: SettingTableViewCell {
    var switchChanging: ((_ isOn: Bool)->())?
    lazy var swItch:UISwitch = {
        let swItch = UISwitch()
//        swItch.addTarget(self, action: #selector(onChange(sender:))
        swItch.setOn( SettingUserDefaultManager.share.isNTMetroViewControllerLeft, animated: false)
        swItch.addTarget(self, action: #selector(onChange(sender:)), for: .valueChanged)
        return swItch
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setingThisSubViews()
        addThisSubViews()
        layoutThisSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setingThisSubViews() {
        super.setingThisSubViews()
    }
    override func addThisSubViews() {
        super.addThisSubViews()
        contentView.addSubview(swItch)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        swItch.snp.makeConstraints({make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
           

        })
//        contentView.backgroundColor = .orange
    }
    @objc func onChange(sender: UISwitch) {
        //start from off
        guard  let switchChanging = switchChanging else {return}
        SettingUserDefaultManager.share.setTabItemsSorting(isNTMetroViewControllerLeft: sender.isOn)
        switchChanging(sender.isOn)

    }
}
class SettingSegmentTableViewCell: SettingTableViewCell {
    var segChanging: ((_ index: Int)->())?
    lazy var segment:UISegmentedControl = {
        let items = ["1" , "2", "3","4","5"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.addTarget(self, action: #selector(onChange(sender:)), for: .valueChanged)
        return customSC
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setingThisSubViews()
        addThisSubViews()
        layoutThisSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setingThisSubViews() {
        super.setingThisSubViews()
    }
    override func addThisSubViews() {
        super.addThisSubViews()
        contentView.addSubview(segment)
    }
    override func layoutSubviews() {
        super.addThisSubViews()
        segment.snp.makeConstraints({make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.leading.equalTo(title.snp.trailing).offset(20)

            
        })

    }
    @objc func onChange(sender: UISegmentedControl) {
        guard let segChanging = segChanging  else {return}
        SettingUserDefaultManager.share.setMetroLineLength(lineLengthLevel: sender.selectedSegmentIndex + 1)
        segChanging(sender.selectedSegmentIndex)
    }
}
class SettingTableViewCell: UITableViewCell,YYxSubViewRules {
    let leadingImageView:UIImageView = {
        let view = UIImageView()
        
        
        return view
    }()
    let title:UILabel = {
        let label = UILabel()
        
        return label
    }()
    
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setingThisSubViews()
        addThisSubViews()
        layoutThisSubViews()
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
    
    func setingThisSubViews() {
        self.selectionStyle = .none
    }
    
    func addThisSubViews() {
        contentView.addSubview(leadingImageView)
        contentView.addSubview(title)

    }
    
    func layoutThisSubViews() {
        leadingImageView.snp.makeConstraints({make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(title.snp.leading).offset(-20)
            make.width.height.equalTo(40)
        })
        title.snp.makeConstraints({make in
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            
        })
    }

}
// Open
extension SettingTableViewCell{
    func setInformation(information:(imageName:String,title:String)){
        leadingImageView.image = UIImage(systemName: information.imageName)
        self.title.text = information.title
    }
}
