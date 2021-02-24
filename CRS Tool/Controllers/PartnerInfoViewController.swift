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
            
            // Language Test
            partnerHaveTestSwitch.setOn(score.partnerHaveTest, animated: true)
            if partnerHaveTestSwitch.isOn {
                testsSegmentedControl.isHidden = false
                
                speakingLabel.isHidden = false
                listeningLabel.isHidden = false
                readingLabel.isHidden = false
                writingLabel.isHidden = false
                
                speakingStepper.isHidden = false
                listeningStepper.isHidden = false
                readingStepper.isHidden = false
                writingStepper.isHidden = false
                
                testsSegmentedControl.selectedSegmentIndex = score.partnerTest.selectedTest
                speakingLabel.text = "\(K.SPEAKING): \(speakings[score.partnerTest.speaking])"
                listeningLabel.text = "\(K.LISTENING): \(listenings[score.partnerTest.listening])"
                readingLabel.text = "\(K.READING): \(readings[score.partnerTest.reading])"
                writingLabel.text = "\(K.WRITING): \(writings[score.partnerTest.writing])"
                
                speakingStepper.value = Double(score.partnerTest.speaking)
                listeningStepper.value = Double(score.partnerTest.listening)
                readingStepper.value = Double(score.partnerTest.reading)
                writingStepper.value = Double(score.partnerTest.writing)
            } else {
                testsSegmentedControl.isHidden = true
                speakingLabel.isHidden = true
                listeningLabel.isHidden = true
                readingLabel.isHidden = true
                writingLabel.isHidden = true
                
                speakingStepper.isHidden = true
                listeningStepper.isHidden = true
                readingStepper.isHidden = true
                writingStepper.isHidden = true
            }
        }
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
        }
    }
    @IBAction func haveTestChanged(_ sender: UISwitch) {
        testsSegmentedControl.isHidden.toggle()
        speakingLabel.isHidden.toggle()
        listeningLabel.isHidden.toggle()
        readingLabel.isHidden.toggle()
        writingLabel.isHidden.toggle()
        
        speakingStepper.isHidden.toggle()
        listeningStepper.isHidden.toggle()
        readingStepper.isHidden.toggle()
        writingStepper.isHidden.toggle()
        
        if let score = score {
            try! realm.write {
            score.partnerHaveTest = sender.isOn
            }
            if sender.isOn {
                speakingLabel.text = "\(K.SPEAKING): \(speakings[score.partnerTest.speaking])"
                listeningLabel.text = "\(K.LISTENING): \(listenings[score.partnerTest.listening])"
                readingLabel.text = "\(K.READING): \(readings[score.partnerTest.reading])"
                writingLabel.text = "\(K.WRITING): \(writings[score.partnerTest.writing])"
            }
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
        title.lineBreakMode = .byWordWrapping;
        title.numberOfLines = 0;
        title.sizeToFit()
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let score = score {
            try! realm.write {
            score.partnerEducation = row
            }
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
        }
    }
    
    // MARK: - Language Test
    
    @IBAction func speakingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
            score.partnerTest.speaking =  Int(sender.value)
            }
            speakingLabel.text = "\(K.SPEAKING): \(speakings[score.partnerTest.speaking])"
        }
    }
    
    @IBAction func listeningChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.partnerTest.listening =  Int(sender.value)}
            listeningLabel.text = "\(K.LISTENING): \(listenings[score.partnerTest.listening])"
        }
    }
    
    @IBAction func readingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.partnerTest.reading =  Int(sender.value)}
            readingLabel.text = "\(K.READING): \(readings[score.partnerTest.reading])"
        }
    }
    
    @IBAction func writingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.partnerTest.writing =  Int(sender.value)}
            writingLabel.text = "\(K.WRITING): \(writings[score.partnerTest.writing])"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ResultViewController
        destination.score = score
    }
}
