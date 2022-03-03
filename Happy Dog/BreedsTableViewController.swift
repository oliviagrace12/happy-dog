//
//  BreedsTableViewController.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 2/27/22.
//

import UIKit

class BreedsTableViewController: UITableViewController {
    
    var breeds: Array<Breed> = Array()
    var breedDictionary: Dictionary<String, Breed> = Dictionary()
    var breedNames: Array<String> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // parse local file
        if let data = readLocalFile(forName: "breeds") {
            breeds = parse(jsonData: data)
        }
        
        // load json
//        self.loadJson(fromUrlRequest: createUrlRequest()) { (result) in
//            switch result {
//                case .success(let data):
//                    print("Request successful")
//                    self.breeds = self.parse(jsonData: data)
//                case .failure(let error):
//                    print("Request failed: \(error)")
//            }
//        }
        
        for breed in breeds {
            breedDictionary[breed.name] = breed
            breedNames.append(breed.name)
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("File reading error: \(error)")
        }
        
        return nil
    }
    
    private func createUrlRequest () -> URLRequest {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-api-key": "ec87e0e5-f352-4670-8d41-f674c3a638de",
            "Content-Type": "application/json"
        ]
        
        return request
    }
    
    private func loadJson(fromUrlRequest urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        urlSession.resume()
    }
    
    private func parse(jsonData: Data) -> Array<Breed> {
        do {
            return try JSONDecoder().decode(Array<Breed>.self, from: jsonData)
        } catch {
            print("Parsing Error: \(error)")
        }
        return Array()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return breeds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)

        cell.textLabel?.text = breedNames[indexPath.row]

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
        if let detailView = segue.destination as? BreedDetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                detailView.breed = breeds[indexPath.row]
            }
        }
        // Pass the selected object to the new view controller.
//        let breedInfo = sender
    }
}
