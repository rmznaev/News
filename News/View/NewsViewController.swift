//
//  ViewController.swift
//  News
//
//  Created by Ramazan Abdullayev on 18.05.21.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getTopStories { result in
            print("NEWS result: \(result)")
            
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
