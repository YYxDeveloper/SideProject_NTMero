//
//  DeclarationViewController.swift
//  ChaseNTMetro
//
//  Created by 呂子揚 on 2021/2/23.
//

import UIKit

class DeclarationViewController: UIViewController,YYxSubViewRules {
    
    
    lazy var textView:UITextView = {
        let textView = UITextView()//            #"ambrus is licensed under CC BY-SA 3.0"#
        textView.font = UIFont.systemFont(ofSize: 22)
        textView.text =
        """
        資料來源：\n
        ambrus is licensed under CC BY-SA 3.0 \n
        新北市大眾捷運
        """
        
        
        
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setingThisSubViews()
        addThisSubViews()
        layoutThisSubViews()
    }
    func setingThisSubViews() {
        
    }
    
    func addThisSubViews() {
        view.addSubview(textView)
    }
    
    func layoutThisSubViews() {
        textView.snp.makeConstraints({make in make.sameAsSuperView()})
        
        
        
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
