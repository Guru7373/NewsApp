//
//  ViewController.swift
//  NewsApp
//
//  Created by Karthi CK on 23/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchQueryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var articlesList: [NewsArticleModal.Articles?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchHeadlines(query: "bitcoin")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseID")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func searchAction(_ sender: Any) {
        guard let searchText = searchQueryTextField.text,
              searchText.count > 0
        else {
            return
        }
        fetchHeadlines(query: searchText)
    }
    
    private func fetchHeadlines(query: String) {
        RestAPIManager.shared.getNewsArticles(input: NewsArticleModal.Request(query: query)) {
            [unowned self] error, article in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let articles = article?.articles {
                print(articles)
                articlesList = articles
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
            
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseID")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseID")
        
        if let item = articlesList?[indexPath.row] {
            cell?.textLabel?.text = item.title
            cell?.detailTextLabel?.text = item.description
        }
        
        return cell!
        
    }
    
}
