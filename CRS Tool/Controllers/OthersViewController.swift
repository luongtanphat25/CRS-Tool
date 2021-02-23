//
//  OthersViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import RealmSwift

class OthersViewController: UIViewController {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var haveCertificate: UISwitch!
    @IBOutlet weak var haveNomination: UISwitch!
    @IBOutlet weak var haveJobOffer: UISwitch!
    
    @IBOutlet weak var nocLabel: UILabel!
    @IBOutlet weak var nocSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let score = score {
            haveCertificate.setOn(score.haveCertificate, animated: true)
            haveNomination.setOn(score.haveNomination, animated: true)
            haveJobOffer.setOn(score.haveJobOffer, animated: true)
            
            if haveJobOffer.isOn {
                nocLabel.isHidden = false
                nocSegmentedControl.isHidden = false
                nocSegmentedControl.selectedSegmentIndex = score.noc
            } else {
                nocLabel.isHidden = true
                nocSegmentedControl.isHidden = true
            }
        }
    }
    
    @IBAction func haveJobOfferChanged(_ sender: UISwitch) {
        nocLabel.isHidden.toggle()
        nocSegmentedControl.isHidden.toggle()
        if let score = score, sender.isOn {
            try! realm.write {
            score.noc = nocSegmentedControl.selectedSegmentIndex
            }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
            score.haveCertificate = haveCertificate.isOn
            score.haveNomination = haveNomination.isOn
            score.haveJobOffer = haveJobOffer.isOn
            score.noc = haveJobOffer.isOn ? nocSegmentedControl.selectedSegmentIndex : score.noc
            }
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CanadianFamilyViewController
        destination.score = score
    }
}
