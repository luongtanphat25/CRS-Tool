//
//  AgeViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-05.
//

import UIKit
import RealmSwift

class AgeViewController: UIViewController {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageScore: UILabel!
    
    @IBOutlet weak var scoreView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let score = score {
            ageSlider.setValue(Float(score.age), animated: true)
            ageLabel.text = "\(Int(score.age))"
            ageScore.text = "+ \(score.ageToScore())"
        }
    }
    
    @IBAction func ageSliderChanged(_ sender: UISlider) {
        if let score = score {
            try! realm.write {
                score.age = Int(ageSlider.value)
            }

            switch ageSlider.value {
            case 17:
                ageLabel.text = "<= 17"
            case 45:
                ageLabel.text = ">= 45"
            default:
                ageLabel.text = "\(Int(ageSlider.value))"
            }
            
            ageScore.text = "+ \(score.ageToScore())"
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
                score.age = Int(ageSlider.value)
            }
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! EducationViewController
        destination.score = score
    }
}
