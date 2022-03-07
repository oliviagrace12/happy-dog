//
//  ViewController.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 2/20/22.
//

import UIKit

class FactsViewController: UIViewController {
    
    var breeds: Array<Breed> = Array()

    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // parse local file
        if let data = readLocalFile(forName: "breeds") {
            breeds = parse(jsonData: data)
        }
    }

    @IBAction func generatePressed(_ sender: UIButton) {
        let index: Int = Int.random(in: 0..<breeds.count)
        let breed = breeds[index]
        
        breedName.text = breed.name
        imageView.loadImageFrom(urlAddress: breed.image.url)
    }
    
    private func parse(jsonData: Data) -> Array<Breed> {
        do {
            return try JSONDecoder().decode(Array<Breed>.self, from: jsonData)
        } catch {
            print("Parsing Error: \(error)")
        }
        return Array()
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
}
