//
//  ExperiencesViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import RealmSwift

class ExperiencesViewController: UIViewController {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var canadaExView: UIView!
    @IBOutlet weak var foriegnExView: UIView!
    @IBOutlet weak var canadaExScore: UILabel!
    @IBOutlet weak var foriegnExScore: UILabel!
    
    @IBOutlet weak var canadianExLabel: UILabel!
    @IBOutlet weak var foreignExLabel: UILabel!
    
    @IBOutlet weak var canadianExStepper: UIStepper!
    @IBOutlet weak var foreignExStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let score = score {
            canadianExStepper.value = Double(score.canadianEx)
            foreignExStepper.value = Double(score.foriegnEx)
            
            canadaExScore.text = "+ \(score.canadianExperienceToScore())"
            foriegnExScore.text = "+ \(score.experienceToScore())"
            
            switch Int(canadianExStepper.value) {
            case 0:
                canadianExLabel.text = K.NONE
            case 1:
                canadianExLabel.text = "1 \(K.YEAR)"
            case 5:
                canadianExLabel.text = ">= 5 \(K.YEARS)"
            default:
                canadianExLabel.text = "\(Int(canadianExStepper.value)) \(K.YEARS)"
            }
            
            switch Int(foreignExStepper.value) {
            case 0:
                foreignExLabel.text = K.NONE
            case 1:
                foreignExLabel.text = "1 \(K.YEAR)"
            case 3:
                foreignExLabel.text = ">= 3 \(K.YEARS)"
            default:
                foreignExLabel.text = "\(Int(foreignExStepper.value)) \(K.YEARS)"
            }
        }
    }
    
    @IBAction func canadianExChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.canadianEx = Int(sender.value)
            }
            
            switch Int(sender.value) {
            case 0:
                canadianExLabel.text = K.NONE
            case 1:
                canadianExLabel.text = "1 \(K.YEAR)"
            case 5:
                canadianExLabel.text = ">= 5 \(K.YEARS)"
            default:
                canadianExLabel.text = "\(Int(sender.value)) \(K.YEARS)"
            }
            canadaExScore.text = "+ \(score.canadianExperienceToScore())"
            foriegnExScore.text = "+ \(score.experienceToScore())"
        }
    }
    
    @IBAction func foreignExChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.foriegnEx = Int(sender.value)
            }
            
            switch Int(sender.value) {
            case 0:
                foreignExLabel.text = K.NONE
            case 1:
                foreignExLabel.text = "1 \(K.YEAR)"
            case 3:
                foreignExLabel.text = ">= 3 \(K.YEARS)"
            default:
                foreignExLabel.text = "\(Int(sender.value)) \(K.YEARS)"
            }
            foriegnExScore.text = "+ \(score.experienceToScore())"
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
                score.canadianEx = Int(canadianExStepper.value)
                score.foriegnEx = Int(foreignExStepper.value)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! OthersViewController
        destination.score = score
    }
    
}
