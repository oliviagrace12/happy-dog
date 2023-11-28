//
//  BreedDetailViewController.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 3/2/22.
//

import UIKit

class BreedDetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var breedGroup: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var lifespan: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var bredFor: UILabel!
    @IBOutlet weak var temperament: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var breed: Breed?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageUrl = breed?.image.url {
            imageView.loadImageFrom(urlAddress: imageUrl)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        name.text = breed?.name
        breedGroup.text = breed?.breed_group
        if let heightText = breed?.height {
            height.text = "\(heightText.imperial) in"
        }
        if let weightText = breed?.weight {
            weight.text = "\(weightText.imperial) lbs"
        }
        lifespan.text = breed?.life_span
        origin.text = breed?.origin
        bredFor.text = breed?.bred_for
        temperament.text = breed?.temperament
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func loadImageFrom(urlAddress: String) {

        if let url = URL(string: urlAddress) {
           URLSession.shared.dataTask(with: url) { (data, response, error) in
             // Error handling...
             guard let imageData = data else { return }

             DispatchQueue.main.async {
               self.image = UIImage(data: imageData)
             }
           }.resume()
         }
    }
}
