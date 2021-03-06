//
//  GroupsTableViewController.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 3/6/22.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    let dataParser: DataParser = DataParser()
    var groupDictionary: Dictionary<String, Array<Breed>> = Dictionary()
    var groups: Array<String> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if (breeds.isEmpty) {
            DataParser().getBreedData()
        }
        
        for breed in breeds {
            let breedGroup = (breed.breed_group != nil && breed.breed_group != "") ? breed.breed_group! : "Other"
            
            if (groupDictionary[breedGroup] == nil) {
                groupDictionary[breedGroup] = [breed]
            } else {
                groupDictionary[breedGroup]!.append(breed)
            }
            
            if (!groups.contains(breedGroup)) {
                groups.append(breedGroup)
            }
        }
        groups = groups.sorted()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicGroup", for: indexPath)

        cell.textLabel?.text = groups[indexPath.row]

        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let singleGroupTableView = segue.destination as? SingleGroupTableViewController else { return }
        guard let indexPath = self.tableView.indexPathForSelectedRow else {return }
        
        singleGroupTableView.breeds = groupDictionary[groups[indexPath.row]]!
    }
    

}
