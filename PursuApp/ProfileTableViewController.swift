//
//  ProfileTableViewController.swift
//  PursuApp
//
//  Created by Robert Miller on 05.02.2022.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    var activities: [Activity] = []
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        activities = StorageManager.shared.fetchFavoriteActivities()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activities.count
     
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = activities[indexPath.row].activity
        content.secondaryText = activities[indexPath.row].type
        content.image = UIImage(systemName: "circle.fill")
        
        content.imageProperties.tintColor = .random()
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            activities.remove(at: indexPath.row)
            StorageManager.shared.deleteActivity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
