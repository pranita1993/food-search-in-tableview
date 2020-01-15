//
//  ViewController.swift
//  foodsearch
//
//  Created by Student P_04 on 13/12/19.
//  Copyright © 2019 Felix ITs. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {
    
    
    var  recipeName = ["pohe","upma","idli","dosa","fried rice","gulabjamun","rasgula","rasmalai","basundi","dhokla","utpa","menduduvada","icecrem"]
    var food = [String]()
    var resultSearchController = UISearchController()
    

    @IBOutlet weak var tblview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = ({
            let controller = UISearchController(searchResultsController:nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            tblview.tableHeaderView = controller.searchBar
            return controller
        })()
        tblview.reloadData()
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (resultSearchController.isActive)
        {
            return food.count
        }
        else
        {
            return recipeName.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if (resultSearchController.isActive)
        {
            cell.textLabel?.text = food[indexPath.row]
            return cell
        }
        else
        {
            cell.textLabel?.text = recipeName[indexPath.row]
            return cell
        }
    }
    func updateSearchResults(for searchController: UISearchController)
    {
        food.removeAll(keepingCapacity:false)
        let searchpredicate = NSPredicate(format: "SELF CONTAINS[C] %@", searchController.searchBar.text!)
        let array = (recipeName as NSArray).filtered(using: searchpredicate)
        food = array as![String]
        self.tblview.reloadData()
        
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

