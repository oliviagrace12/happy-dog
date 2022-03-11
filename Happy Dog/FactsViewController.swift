//
//  ViewController.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 2/20/22.
//

import UIKit

var breeds: Array<Breed> = Array()

class FactsViewController: UIViewController {
    
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    let dataParser: DataParser = DataParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // parse local file
        dataParser.getBreedData()
    }

    @IBAction func generatePressed(_ sender: UIButton) {
        let index: Int = Int.random(in: 0..<breeds.count)
        let breed = breeds[index]
        
        imageView.loadImageFrom(urlAddress: breed.image.url)
        breedName.text = breed.name
    }
}
