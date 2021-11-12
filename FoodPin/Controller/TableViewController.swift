//
//  TableViewController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/1.
//

import UIKit


class TableViewController: UITableViewController {
    
    @IBOutlet var bottomLabel: UILabel!
    
    var arr = [""]
    
    var label123 = ""
    
    var ilike = ""
    
    var restaurants:[Restaurant] = []
    
    lazy var dataSource = configureDataSource()
    
    
    
    // MARK: - UITableView Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initilized the data source
        Restaurant.generateData(sourceArray: &restaurants)
        tableView.dataSource = dataSource
        
        //Create the snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
        //configure the navigation topic?
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> DiffableDataSource {
        let cellIdentifier = "datacell"
        
        let dataSource = DiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
                
                //configure the cell's data
                cell.nameLabel.text = restaurant.name
                cell.thumbnailImageView.image = UIImage(named: restaurant.image)
                cell.accessoryType = restaurant.isFavorite ? .checkmark : .none
                
                return cell
            }
        )
        
        return dataSource
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    //        let cell = tableView.cellForRow(at: indexPath) //return the currentl selected cell
    //        cell?.accessoryType = .checkmark
    //        restaurants[indexPath.row].isFavorite = true
    //
    //        tableView.deselectRow(at: indexPath, animated: false) //de-selection
    //    }
    
    
    
    
    
    // MARK: - UITableView Diffable Swipe Actions
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Mark as favorite action
        let dislikeAction = UIContextualAction(style: .destructive, title: "dislike") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            //update source array
            self.restaurants[indexPath.row].isFavorite = false
            
            
            //update data source of the tableview
            var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
            snapshot.appendSections([.all])
            snapshot.appendItems(self.restaurants, toSection: .all)
            self.dataSource.apply(snapshot, animatingDifferences: false)
            
            //update cell
            cell.accessoryType = self.restaurants[indexPath.row].isFavorite ? .none : .none
           
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
            self.checkdelete(indexPath: indexPath)
        }
        
        //Change the action's color and icon
        dislikeAction.backgroundColor = UIColor.systemYellow
        dislikeAction.image = UIImage(systemName: self.restaurants[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.slash.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [dislikeAction])
        
        
        
        return swipeConfiguration
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Delete action
        let likeAction = UIContextualAction(style: .destructive, title: "Like") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            //update source array
            self.restaurants[indexPath.row].isFavorite = true
            
            
            //update data source of the tableview
            var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
            snapshot.appendSections([.all])
            snapshot.appendItems(self.restaurants, toSection: .all)
            self.dataSource.apply(snapshot, animatingDifferences: false)
            
            //update cell
            cell.accessoryType = self.restaurants[indexPath.row].isFavorite ? .checkmark : .checkmark
            
            
            
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
            self.checkSelection(indexPath: indexPath)
        }
        
        likeAction.backgroundColor = UIColor.systemYellow
        likeAction.image = UIImage(systemName: self.restaurants[indexPath.row].isFavorite ? "heart.fill" : "heart.fill")
        
        // Share action
        //    let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
        //    let defaultText = "Just checking in at " + restaurant.name
        //    let imageToShare = UIImage(named: restaurant.image)! //make sure always have the image
        //
        //    let activityController: UIActivityViewController
        //    activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
        //
        //    //popover solution code
        //
        //    self.present(activityController, animated: true, completion: nil)
        //    completionHandler(true)
        //    }
        
        // Change the action's color and icon
        
        // Configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [likeAction])
        
        
        
        return swipeConfiguration
        
        
    }
    
    
    // MARK: - bottom label
    func checkSelection(indexPath: IndexPath){
        
        //if(!self.restaurants[indexPath.row].isFavorite){
            //ilike = ilike + self.restaurants[indexPath.row].name + " "
            
        //}
        
        arr.removeAll{$0 == restaurants[indexPath.row].name}
        //arr.remove(object: restaurants[indexPath.row].name)
        arr.append(restaurants[indexPath.row].name)
        arr = arr.sorted()
        label123 = arr.joined(separator: " ")
        bottomLabel.text = "I like: " + label123
        
        
    }
    
    func checkdelete(indexPath: IndexPath){
        arr.removeAll{$0 == restaurants[indexPath.row].name}
        arr = arr.sorted()
        label123 = arr.joined(separator: " ")
        bottomLabel.text = "I like: " + label123
    }

    
    
    // MARK: - For Segue's function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                destinationController.restaurantImageName = restaurants[indexPath.row].image
            }
        }
    }
    
}
