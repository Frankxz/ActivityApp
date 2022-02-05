//
//  CardViewController.swift
//  PursuApp
//
//  Created by Robert Miller on 11.01.2022.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivity()
    }
    
    func configure(activity: Activity){
        nameLabel.text = activity.activity
        typeLabel.text = activity.type
        priceLabel.text = String(activity.price!)
        participantsLabel.text = String(activity.participants!)
    }
    func loadActivity(){
        guard let url = URL(string: "https://www.boredapi.com/api/activity/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Unknown error description")
                return
            }
            do {
                var activity: Activity
                activity = try
                JSONDecoder().decode(Activity.self, from: data)
                DispatchQueue.main.async {
                    self.configure(activity: activity)
                }
            } catch let error{
                print(String(describing: error))
            }
        }.resume()

    }
    
}
