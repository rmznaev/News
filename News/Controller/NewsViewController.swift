//
//  ViewController.swift
//  News
//
//  Created by Ramazan Abdullayev on 18.05.21.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    private var viewModels = [NewsCellModel]()
    private var articles = [Article]()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(NewsTableViewCell.self,
                      forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchTopStories()
    }
    
    private func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            print("NEWS result: \(result)")
            
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap {
                    NewsCellModel(title: $0.title,
                                  subtitle: $0.description ?? "No Description",
                                  imageURL: URL(string: $0.urlToImage ?? ""))
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = self.view.bounds
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NewsTableViewCell.identifier,
                for: indexPath
        ) as? NewsTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
