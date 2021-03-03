//
//  PartnerInfoViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import RealmSwift

class PartnerInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewA: UIView!
    @IBOutlet weak var scoreA: UILabel!
    
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var scoreB: UILabel!
    
    @IBOutlet weak var viewC: UIView!
    @IBOutlet weak var scoreC: UILabel!
    @IBOutlet weak var viewScore: UIView!
    
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var partnerExLabel: UILabel!
    @IBOutlet weak var partnerExStepper: UIStepper!
    
    @IBOutlet weak var educationLevelPicker: UIPickerView!
    
    @IBOutlet weak var partnerHaveTestSwitch: UISwitch!
    @IBOutlet weak var testsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var speakingLabel: UILabel!
    @IBOutlet weak var listeningLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    
    @IBOutlet weak var speakingStepper: UIStepper!
    @IBOutlet weak var listeningStepper: UIStepper!
    @IBOutlet weak var readingStepper: UIStepper!
    @IBOutlet weak var writingStepper: UIStepper!
    
    var speakings: [String] { get { K.LANGUAGE_TESTS[score!.partnerTest.selectedTest].speaking } }
    var listenings: [String] { get { K.LANGUAGE_TESTS[score!.partnerTest.selectedTest].listening } }
    var readings: [String] { get { K.LANGUAGE_TESTS[score!.partnerTest.selectedTest].reading } }
    var writings: [String] { get { K.LANGUAGE_TESTS[score!.partnerTest.selectedTest].writing } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        educationLevelPicker.delegate = self
        educationLevelPicker.dataSource = self
        
        if let score = score {
            //Education
            educationLevelPicker.selectRow(score.partnerEducation, inComponent: 0, animated: true)
            scoreA.text = "+ \(score.partnerEducationToScore())"
            
            //Experience
            partnerExStepper.value = Double(score.partnerEx)
            switch Int(partnerExStepper.value) {
            case 0:
                partnerExLabel.text = K.NONE
            case 1:
                partnerExLabel.text = "1 \(K.YEAR)"
            case 5:
                partnerExLabel.text = ">= 5 \(K.YEARS)"
            default:
                partnerExLabel.text = "\(Int(partnerExStepper.value)) \(K.YEARS)"
            }
            scoreB.text = "+ \(score.partnerExperienceToScore())"
            
            // Language Test
            partnerHaveTestSwitch.setOn(score.partnerHaveTest, animated: true)
            if partnerHaveTestSwitch.isOn {
                viewScore.isHidden = false
                viewC.isHidden = false
                
                testsSegmentedControl.selectedSegmentIndex = score.partnerTest.selectedTest
                speakingLabel.text = "\(K.SPEAKING): \(speakings[score.partnerTest.speaking])"
                listeningLabel.text = "\(K.LISTENING): \(listenings[score.partnerTest.listening])"
                readingLabel.text = "\(K.READING): \(readings[score.partnerTest.reading])"
                writingLabel.text = "\(K.WRITING): \(writings[score.partnerTest.writing])"
                
                speakingStepper.value = Double(score.partnerTest.speaking)
                listeningStepper.value = Double(score.partnerTest.listening)
                readingStepper.value = Double(score.partnerTest.reading)
                writingStepper.value = Double(score.partnerTest.writing)
                
                scoreC.text = "+ \(score.partnerCLBToScore())"
            } else {
                viewScore.isHidden = true
                viewC.isHidden = true
            }
            testView.backgroundColor = score.partnerHaveTest ? UIColor.white : UIColor(named: K.BACKGROUND)
        }
        
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        scrollView.setContentOffset(.zero, animated: true)
        scrollView.contentSize.height -= partnerHaveTestSwitch.isOn ? 0 : viewScore.frame.height
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
            score.partnerEducation = educationLevelPicker.selectedRow(inComponent: 0)
            score.partnerEx = Int(partnerExStepper.value)
            score.partnerHaveTest = partnerHaveTestSwitch.isOn
            
            score.partnerTest.selectedTest = testsSegmentedControl.selectedSegmentIndex
            score.partnerTest.speaking = Int(speakingStepper.value)
            score.partnerTest.listening = Int(listeningStepper.value)
            score.partnerTest.reading = Int(readingStepper.value)
            score.partnerTest.writing = Int(writingStepper.value)
            }
        }
    }
    
    @IBAction func partnerExChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
            score.partnerEx = Int(sender.value)
            }
            switch Int(sender.value) {
            case 0:
                partnerExLabel.text = K.NONE
            case 1:
                partnerExLabel.text = "1 \(K.YEAR)"
            case 5:
                partnerExLabel.text = ">= 5 \(K.YEARS)"
            default:
                partnerExLabel.text = "\(Int(sender.value)) \(K.YEARS)"
            }
            scoreB.text = "+ \(score.partnerExperienceToScore())"
        }
    }
    @IBAction func haveTestChanged(_ sender: UISwitch) {
        viewScore.isHidden.toggle()
        viewC.isHidden.toggle()
        testView.backgroundColor = sender.isOn ? UIColor.white : UIColor(named: K.BACKGROUND)
        if let score = score {
            try! realm.write {
            score.partnerHaveTest = sender.isOn
            }
            if sender.isOn {
                speakingLabel.text = "\(K.SPEAKING): \(speakings[score.partnerTest.speaking])"
                listeningLabel.text = "\(K.LISTENING): \(listenings[score.partnerTest.listening])"
                readingLabel.text = "\(K.READING): \(readings[score.partnerTest.reading])"
                writingLabel.text = "\(K.WRITING): \(writings[score.partnerTest.writing])"
                
                scrollView.contentSize.height += viewScore.frame.height
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom), animated: true)
            } else {
                scrollView.contentSize.height -= viewScore.frame.height
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom), animated: true)
            }
            scoreC.text = "+ \(score.partnerCLBToScore())"
        }
    }
    // MARK: - Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.EDUCATION_LEVELS.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width - 30, height: 50))
        title.text = K.EDUCATION_LEVELS[row]
        title.font = UIFont(name: "System", size: 17)
        title.textColor = UIColor(named: K.TEXT)
        title.numberOfLines = 0;
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let score = score {
            try! realm.write {
            score.partnerEducation = row
            }
            scoreA.text = "+ \(score.partnerEducationToScore())"
        }
    }
    
    // MARK: - Test Change
    
    @IBAction func testChanged(_ sender: UISegmentedControl) {
        if let score = score {
            try! realm.write {
            score.partnerTest.selectedTest = sender.selectedSegmentIndex
            }
            
            speakingLabel.text = "\(K.SPEAKING): \(speakings[score.partnerTest.speaking])"
            listeningLabel.text = "\(K.LISTENING): \(listenings[score.partnerTest.listening])"
            readingLabel.text = "\(K.READING): \(readings[score.partnerTest.reading])"
            writingLabel.text = "\(K.WRITING): \(writings[score.partnerTest.writing])"
            scoreC.text = "+ \(score.partnerCLBToScore())"
        }
    }
    
    // MARK: - Language Test
    
    @IBAction func speakingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
            score.partnerTest.speaking =  Int(sender.value)
            }
            speakingLabel.text = "\(K.SPEAKING): \(speakings[score.partnerTest.speaking])"
            scoreC.text = "+ \(score.partnerCLBToScore())"
        }
    }
    
    @IBAction func listeningChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.partnerTest.listening =  Int(sender.value)}
            listeningLabel.text = "\(K.LISTENING): \(listenings[score.partnerTest.listening])"
            scoreC.text = "+ \(score.partnerCLBToScore())"
        }
    }
    
    @IBAction func readingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.partnerTest.reading =  Int(sender.value)}
            readingLabel.text = "\(K.READING): \(readings[score.partnerTest.reading])"
            scoreC.text = "+ \(score.partnerCLBToScore())"
        }
    }
    
    @IBAction func writingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.partnerTest.writing =  Int(sender.value)}
            writingLabel.text = "\(K.WRITING): \(writings[score.partnerTest.writing])"
            scoreC.text = "+ \(score.partnerCLBToScore())"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ResultViewController
        destination.score = score
    }
}
