//
//  CanadianFamilyViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import RealmSwift

class CanadianFamilyViewController: UIViewController {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var viewA: UIView!
    @IBOutlet weak var familyScore: UILabel!
    
    @IBOutlet weak var haveCanadianFamily: UISwitch!
    
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var haveNomination: UISwitch!
    @IBOutlet weak var scoreB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let score = score {
            haveCanadianFamily.setOn(score.haveCanadianFamily, animated: true)
            familyScore.text = "+ \(score.haveCanadianFamily ? 15 : 0)"
            haveNomination.setOn(score.haveNomination, animated: true)
            viewA.isHidden = !score.haveCanadianFamily
            scoreB.text = "+ \(score.haveNomination ? 600 : 0)"
            viewB.isHidden = !score.haveNomination
        }
    }
    
    @IBAction func haveFamilyChanged(_ sender: UISwitch) {
        if let score = score {
            try! realm.write {
                score.haveCanadianFamily = sender.isOn
            }
            familyScore.text = "+ \(score.haveCanadianFamily ? 15 : 0)"
            viewA.isHidden = !sender.isOn
        }
    }
    
    @IBAction func haveNominationChanged(_ sender: UISwitch) {
        if let score = score {
            try! realm.write {
                score.haveNomination = sender.isOn
            }
            scoreB.text = "+ \(score.haveNomination ? 600 : 0)"
            viewB.isHidden = !sender.isOn
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
                score.haveCanadianFamily = haveCanadianFamily.isOn
                score.haveNomination = haveNomination.isOn
            }
            if score.havePartner {
                performSegue(withIdentifier: K.FAMILY_TO_PARTNER, sender: self)
            } else {
                performSegue(withIdentifier: K.FAMILY_TO_RESULT, sender: self)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.FAMILY_TO_PARTNER {
            let destination = segue.destination as! PartnerInfoViewController
            destination.score = score
        } else if segue.identifier == K.FAMILY_TO_RESULT {
            let destination = segue.destination as! ResultViewController
            destination.score = score
        }
    }
}
