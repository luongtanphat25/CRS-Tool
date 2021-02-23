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
    
    @IBOutlet weak var haveCanadianFamily: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let score = score {
            haveCanadianFamily.setOn(score.haveCanadianFamily, animated: true)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
                score.haveCanadianFamily = haveCanadianFamily.isOn
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
