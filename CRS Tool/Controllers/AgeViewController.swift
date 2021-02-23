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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let score = score {
            ageSlider.setValue(Float(score.age), animated: true)
            ageLabel.text = "\(Int(score.age))"
        }
    }
    
    @IBAction func ageSliderChanged(_ sender: UISlider) {
        if let score = score {
            do {
                try realm.write {
                    score.age = Int(ageSlider.value)
                }
            } catch { print(error) }

            switch ageSlider.value {
            case 17:
                ageLabel.text = "<= 17"
            case 45:
                ageLabel.text = ">= 45"
            default:
                ageLabel.text = "\(Int(ageSlider.value))"
            }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            do {
                try realm.write {
                    score.age = Int(ageSlider.value)
                }
            } catch { print(error) }
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! EducationViewController
        destination.score = score
    }
}
