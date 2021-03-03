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
    
    @IBOutlet weak var viewA: UIView!
   
    @IBOutlet weak var viewC: UIView!
    
    @IBOutlet weak var haveCertificate: UISwitch!
   
    @IBOutlet weak var haveJobOffer: UISwitch!
    
   
    @IBOutlet weak var scoreA: UILabel!
    
    @IBOutlet weak var scoreC: UILabel!
    @IBOutlet weak var bigView: UIView!
    
    
    @IBOutlet weak var nocSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let score = score {
            haveCertificate.setOn(score.haveCertificate, animated: true)
            
            haveJobOffer.setOn(score.haveJobOffer, animated: true)
            
            if haveJobOffer.isOn {
                nocSegmentedControl.isHidden = false
                nocSegmentedControl.selectedSegmentIndex = score.noc
            } else {
                nocSegmentedControl.isHidden = true
            }
            
            scoreA.text = "+ \(score.certificateAndCLBToScore())"
           
            scoreC.text = "+ \(score.jobOfferToScore())"
            
            viewA.isHidden = !score.haveCertificate
            
            viewC.isHidden = !score.haveJobOffer
            
            bigView.backgroundColor = score.haveJobOffer ? UIColor.white : UIColor(named: K.BACKGROUND)
        }
    }
    @IBAction func haveCertificateChanged(_ sender: UISwitch) {
        if let score = score {
            try! realm.write {
                score.haveCertificate = sender.isOn
            }
            scoreA.text = "+ \(score.certificateAndCLBToScore())"
            viewA.isHidden = !sender.isOn
        }
    }
    
    @IBAction func haveJobOfferChanged(_ sender: UISwitch) {
        nocSegmentedControl.isHidden.toggle()
        if let score = score {
            try! realm.write {
                score.haveJobOffer = sender.isOn
            }
            scoreC.text = "+ \(score.jobOfferToScore())"
            viewC.isHidden = !sender.isOn
        }
        bigView.backgroundColor = sender.isOn ? UIColor.white : UIColor(named: K.BACKGROUND)
    }
    @IBAction func nocChanged(_ sender: UISegmentedControl) {
        if let score = score {
            try! realm.write{
                score.noc = sender.selectedSegmentIndex
            }
            scoreC.text = "+ \(score.jobOfferToScore())"
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
            score.haveCertificate = haveCertificate.isOn
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
