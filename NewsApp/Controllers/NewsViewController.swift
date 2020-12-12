//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 11.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UISearchBarDelegate {

    var tableViewController: NewsTableViewController?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NewsClient.shared.addFilter(key: "q", value: searchText)
        tableViewController?.doRefesh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        tableViewController = storyBoard.instantiateViewController(withIdentifier: "newsController") as! NewsTableViewController
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let nextController = segue.destination as? FilterViewController {
            NewsClient.shared.getArticles(success: { articles in
                nextController.sourceDelegate.sources = ["All"]
                for article in articles {
                    if article.source.name != nil && article.source.name != "" {
                        if nextController.sourceDelegate.sources.contains(article.source.name!) {
                            
                        }
                        else {
                            nextController.sourceDelegate.sources.append(article.source.name!)
                        }
                    }
                }
                nextController.sourcePickerView.reloadAllComponents()
            })
        }
    }

}
