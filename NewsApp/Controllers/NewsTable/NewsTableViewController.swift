//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 11.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

//    var data : [Article] = []
    var data : [NewsData] = []
    var isLoadingData = false
    var pagenum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        doRefesh()
    }
    
    func setPage(newPage: Int) {
        pagenum = newPage
        NewsClient.shared.addFilter(key: "page",value: "\(self.pagenum)")
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if !isLoadingData {
                    isLoadingData = true
                    self.setPage(newPage: self.pagenum + 1)
                    getNewData()
                }
            }
        }
    }
    
    func getNewData() {
        NewsClient.shared.getArticles(success: { articles in
            for article in articles {
                self.data.append(NewsData(article: article, tableview: self.tableView))
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                self.isLoadingData = false
            }
        })
    }
    
    func doRefesh() {
        isLoadingData = true
        self.setPage(newPage: 1)
        self.data.removeAll()
        print("*** REMOVING ALL *** ")
        getNewData()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        doRefesh()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as! NewsTableViewCell
        if indexPath.row >= data.count {
            return cell
        }
        cell.title.text = data[indexPath.row].title
        cell.info.text = data[indexPath.row].info
        cell.time.text = data[indexPath.row].date
        cell.pic.image = data[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard data[indexPath.row].url != nil else {return}
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "webView") as! WebViewController
        nextViewController.urlString = data[indexPath.row].url!
        navigationController!.pushViewController(nextViewController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
