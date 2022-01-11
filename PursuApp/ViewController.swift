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
    
    let activityCount = 5
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
