//
//  ResultViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import RealmSwift

class ResultViewController: UIViewController {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var granTotalLabel: UILabel!
    
    @IBOutlet weak var coreTotalLabel: UILabel!
    @IBOutlet weak var levelEducationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var firstLanguageLabel: UILabel!
    @IBOutlet weak var secondLanguageLabel: UILabel!
    @IBOutlet weak var canadianWorkLabel: UILabel!
    
    @IBOutlet weak var spouseLabel: UILabel!
    @IBOutlet weak var spouseEducationLabel: UILabel!
    @IBOutlet weak var spouseLanguageLabel: UILabel!
    @IBOutlet weak var spouseExperienceLabel: UILabel!
    
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var educationSkillLabel: UILabel!
    @IBOutlet weak var languageAndEducationLabel: UILabel!
    @IBOutlet weak var workAndEducationLabel: UILabel!
    
    @IBOutlet weak var foreignToTalLabel: UILabel!
    @IBOutlet weak var languageAndForeignLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var certificateLabel: UILabel!
    
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var nominationLabel: UILabel!
    @IBOutlet weak var jobOfferLabel: UILabel!
    @IBOutlet weak var studyCanadaLabel: UILabel!
    @IBOutlet weak var siblingLabel: UILabel!
    @IBOutlet weak var frenchLabel: UILabel!
    
    @IBOutlet weak var resultView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = resultView.layer.frame.width/2
        
        if let score = score {
            ageLabel.text! += "\(score.ageToScore())"
            levelEducationLabel.text! += "\(score.educationToScore())"
            firstLanguageLabel.text! += "\(score.firstTestToScore())"
            secondLanguageLabel.text! += "\(score.secondTestToScore())"
            canadianWorkLabel.text! += "\(score.canadianExperienceToScore())"
            let totalA = score.ageToScore() + score.educationToScore() + score.firstTestToScore() + score.secondTestToScore() + score.canadianExperienceToScore()
            coreTotalLabel.text! += "\(totalA)"
            
            
            spouseEducationLabel.text! += "\(score.partnerEducationToScore())"
            spouseLanguageLabel.text! += "\(score.partnerCLBToScore())"
            spouseExperienceLabel.text! += "\(score.partnerExperienceToScore())"
            let totalB = score.partnerEducationToScore() + score.partnerExperienceToScore() + score.partnerCLBToScore()
            spouseLabel.text! += "\(totalB)"
            
            
            languageAndEducationLabel.text! += "\(score.clbAndEducationToScore())"
            workAndEducationLabel.text! += "\(score.workAndEducationToScore())"
            var educationTotal = score.clbAndEducationToScore() + score.workAndEducationToScore()
            educationTotal = (educationTotal >= 50) ? 50 : educationTotal
            educationSkillLabel.text! += "\(educationTotal)"
            
            
            languageAndForeignLabel.text! += "\(score.foreignWorkAndCLBToScore())"
            workLabel.text! += "\(score.experienceToScore())"
            var foreignTotal = score.foreignWorkAndCLBToScore() + score.experienceToScore()
            foreignTotal = (foreignTotal >= 50) ? 50 : foreignTotal
            foreignToTalLabel.text! += "\(foreignTotal)"
            certificateLabel.text! += "\(score.certificateAndCLBToScore())"
            var totalC = score.certificateAndCLBToScore() + educationTotal + foreignTotal
            totalC = (totalC >= 100) ? 100 : totalC
            skillLabel.text! += "\(totalC)"
            
            let nominationScore = score.haveNomination ? 600 : 0
            nominationLabel.text! += "\(nominationScore)"
            jobOfferLabel.text! += "\(score.jobOfferToScore())"
            studyCanadaLabel.text! += "\(score.studyCanadaToScore())"
            
            let siblingScore = score.haveCanadianFamily ? 15 : 0
            siblingLabel.text! += "\(siblingScore)"
            frenchLabel.text! += "\(score.frenchSkillToScore())"
            
            var totalD = score.frenchSkillToScore() + score.studyCanadaToScore() + score.jobOfferToScore() + nominationScore + siblingScore
            
            totalD = totalD >= 600 ? 600 : totalD
            
            additionalLabel.text! += "\(totalD)"
            
            let total = totalA + totalB + totalC + totalD
            
            granTotalLabel.text! = "\(total)"
            try! realm.write { score.finalScore = total }
            
            resultView.backgroundColor = UIColor(named: setColor(score: score.finalScore))
        }
    }
    @IBAction func tryAgainButtonPressed(_ sender: UIBarButtonItem) {
        if let nav = self.navigationController {
            for controller in nav.viewControllers {
                if controller is ScoresTableViewController {
                    nav.popToViewController(controller, animated:true)
                    break
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func setColor(score: Int) -> String {
        switch score {
        case ...200:
            return K.BLUE_DARK
        case ...400:
            return K.BLUE_LIGHT
        case ...600:
            return K.GREEN_LIGHT
        case ...800:
            return K.YELLOW
        default:
            return K.ORANGE
        }
    }
}
