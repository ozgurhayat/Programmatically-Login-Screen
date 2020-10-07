//
//  SecondViewController.swift
//  Login Screen - Programmatic
//
//  Created by Ozgur Hayat on 07/10/2020.
//

import UIKit

class SecondViewController: UIViewController {

    var welcomePageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeText()
        view.backgroundColor = UIColor(red:102/255, green:204/255, blue:255/255, alpha:1.0)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func welcomeText() {
        welcomePageLabel.font = UIFont.systemFont(ofSize: 36)
        welcomePageLabel.text = "You're Awesome!!"
        welcomePageLabel.textColor = .white
        welcomePageLabel.textAlignment = .center
        welcomePageLabel.numberOfLines = 0
        welcomePageLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(welcomePageLabel)
        
        
        welcomePageLabel.translatesAutoresizingMaskIntoConstraints                                                          = false
        welcomePageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive           = true
        welcomePageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive   = true
        welcomePageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
}
