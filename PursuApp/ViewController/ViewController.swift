//
//  ViewController.swift
//  PursuApp
//
//  Created by Robert Miller on 02.12.2021.
//

import UIKit
import Koloda

class ViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    var activities:[Activity] = []
    let activityCount = 50
    var containers = [CardViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContainerView()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadContainerView()
        kolodaView.reloadData()
    }
    

    
    func loadContainerView(){
        for _ in 0...activityCount - 1{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
            self.addChild(vc)
            
            containers.append(vc)
        }
    }
    
    
    @IBAction func dislikeAction(_ sender: UIButton) {
        kolodaView.swipe(.left)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        kolodaView.swipe(.right)
    }
    
    @IBAction func reloadAction(_ sender: UIButton) {
        kolodaView.resetCurrentCardIndex()
        kolodaView.reloadData()
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        false
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){
        switch direction {
        case .right, .topRight, .bottomRight:
            guard let activity = containers[kolodaView.currentCardIndex - 1].activity else { return }
            StorageManager.shared.save(activity: activity)
        default:
            break
        }
    }
}



extension ViewController: KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let container = containers[index]
      
        return container.view
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        activityCount
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        .default
    }
    
    
}

extension ViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
}



extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

