//
//  LanguagesViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import RealmSwift

class LanguagesViewController: UIViewController {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstLanguageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var secondLanguageSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var secondTestView: UIView!
    @IBOutlet weak var firstScoreView: UIView!
    @IBOutlet weak var secondScoreView: UIView!
    @IBOutlet weak var firstScore: UILabel!
    @IBOutlet weak var secondScore: UILabel!
    @IBOutlet weak var secondLanguageView: UIView!
    
    @IBOutlet weak var haveSecondLanguageSwitch: UISwitch!
    
    @IBOutlet weak var speakingLabel: UILabel!
    @IBOutlet weak var listeningLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    
    @IBOutlet weak var speakingStepper: UIStepper!
    @IBOutlet weak var listeningStepper: UIStepper!
    @IBOutlet weak var readingStepper: UIStepper!
    @IBOutlet weak var writingStepper: UIStepper!
    
    @IBOutlet weak var secondSpeakingLabel: UILabel!
    @IBOutlet weak var secondListeningLabel: UILabel!
    @IBOutlet weak var secondReadingLabel: UILabel!
    @IBOutlet weak var secondWritingLabel: UILabel!
    
    @IBOutlet weak var secondSpeakingStepper: UIStepper!
    @IBOutlet weak var secondListeningStepper: UIStepper!
    @IBOutlet weak var secondReadingStepper: UIStepper!
    @IBOutlet weak var secondWritingStepper: UIStepper!
    
    var speakings: [String] { get { K.LANGUAGE_TESTS[score!.firstTest.selectedTest].speaking } }
    var listenings: [String] { get { K.LANGUAGE_TESTS[score!.firstTest.selectedTest].listening } }
    var readings: [String] { get { K.LANGUAGE_TESTS[score!.firstTest.selectedTest].reading } }
    var writings: [String] { get { K.LANGUAGE_TESTS[score!.firstTest.selectedTest].writing } }
    
    var secondTests: [Test] {
        get {
            let firstSelectedTest = score!.firstTest.selectedTest
            return (firstSelectedTest == 0 || firstSelectedTest == 1) ? K.FRENCH_TESTS : K.ENGLISH_TESTS
        }
    }
    
    var secondSpeakings: [String] { get { secondTests[score!.secondTest.selectedTest].speaking } }
    var secondListenings: [String] { get { secondTests[score!.secondTest.selectedTest].listening } }
    var secondReadings: [String] { get { secondTests[score!.secondTest.selectedTest].reading } }
    var secondWritings: [String] { get { secondTests[score!.secondTest.selectedTest].writing } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        
        if let score = score {
            // Second Test
            haveSecondLanguageSwitch.setOn(score.haveSecondLanguage, animated: true)
            if haveSecondLanguageSwitch.isOn {
                for i in 0..<secondTests.count {
                    secondLanguageSegmentedControl.setTitle(secondTests[i].name, forSegmentAt: i)
                }
                secondLanguageSegmentedControl.selectedSegmentIndex = score.secondTest.selectedTest
                
                secondScoreView.isHidden = false
                secondLanguageView.isHidden = false
                
                secondSpeakingLabel.text = "\(K.SPEAKING): \(secondSpeakings[score.secondTest.speaking])"
                secondListeningLabel.text = "\(K.LISTENING): \(secondListenings[score.secondTest.listening])"
                secondReadingLabel.text = "\(K.READING): \(secondReadings[score.secondTest.reading])"
                secondWritingLabel.text = "\(K.WRITING): \(secondWritings[score.secondTest.writing])"
                
                secondSpeakingStepper.value = Double(score.secondTest.speaking)
                secondListeningStepper.value = Double(score.secondTest.listening)
                secondReadingStepper.value = Double(score.secondTest.reading)
                secondWritingStepper.value = Double(score.secondTest.writing)
                
                scrollView.isScrollEnabled = true
            } else {
                secondScoreView.isHidden = true
                secondLanguageView.isHidden = true
                scrollView.isScrollEnabled = false
            }
            
            //First test
            firstLanguageSegmentedControl.selectedSegmentIndex = score.firstTest.selectedTest
            
            speakingStepper.value = Double(score.firstTest.speaking)
            listeningStepper.value = Double(score.firstTest.listening)
            readingStepper.value = Double(score.firstTest.reading)
            writingStepper.value = Double(score.firstTest.writing)
            
            speakingLabel.text = "\(K.SPEAKING): \(speakings[score.firstTest.speaking])"
            listeningLabel.text = "\(K.LISTENING): \(listenings[score.firstTest.listening])"
            readingLabel.text = "\(K.READING): \(readings[score.firstTest.reading])"
            writingLabel.text = "\(K.WRITING): \(writings[score.firstTest.writing])"
            
            firstScore.text = "+ \(score.firstTestToScore())"
            secondScore.text = "+ \(score.secondTestToScore())"
            
            secondTestView.backgroundColor = score.haveSecondLanguage ? UIColor.white : UIColor(named: K.BACKGROUND)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
                score.firstTest.selectedTest = firstLanguageSegmentedControl.selectedSegmentIndex
                score.firstTest.speaking = Int(speakingStepper.value)
                score.firstTest.listening = Int(listeningStepper.value)
                score.firstTest.reading = Int(readingStepper.value)
                score.firstTest.writing = Int(writingStepper.value)
                
                score.haveSecondLanguage = haveSecondLanguageSwitch.isOn
                
                score.secondTest.selectedTest = secondLanguageSegmentedControl.selectedSegmentIndex
                score.secondTest.speaking = Int(secondSpeakingStepper.value)
                score.secondTest.listening = Int(secondListeningStepper.value)
                score.secondTest.reading = Int(secondReadingStepper.value)
                score.secondTest.writing = Int(secondWritingStepper.value)
            }
        }
    }
    // MARK: - First Test
    
    @IBAction func speakingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.firstTest.speaking =  Int(sender.value)
                speakingLabel.text = "\(K.SPEAKING): \(speakings[score.firstTest.speaking])"
            }
            firstScore.text = "+ \(score.firstTestToScore())"
        }
    }
    
    @IBAction func listeningChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.firstTest.listening =  Int(sender.value)
                listeningLabel.text = "\(K.LISTENING): \(listenings[score.firstTest.listening])"
            }
            firstScore.text = "+ \(score.firstTestToScore())"
        }
    }
    
    @IBAction func readingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.firstTest.reading =  Int(sender.value)
                readingLabel.text = "\(K.READING): \(readings[score.firstTest.reading])"
            }
            firstScore.text = "+ \(score.firstTestToScore())"
        }
    }
    
    @IBAction func writingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.firstTest.writing =  Int(sender.value)
                writingLabel.text = "\(K.WRITING): \(writings[score.firstTest.writing])"
            }
            firstScore.text = "+ \(score.firstTestToScore())"
        }
    }
    
    // MARK: - Second Test
    
    @IBAction func secondSpeakingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.secondTest.speaking =  Int(sender.value)
                secondSpeakingLabel.text = "\(K.SPEAKING): \(secondSpeakings[score.secondTest.speaking])"
            }
            secondScore.text = "+ \(score.secondTestToScore())"
        }
    }
    
    @IBAction func secondListeningChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.secondTest.listening =  Int(sender.value)
                secondListeningLabel.text = "\(K.LISTENING): \(secondListenings[score.secondTest.listening])"
            }
            secondScore.text = "+ \(score.secondTestToScore())"
        }
    }
    
    @IBAction func secondReadingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.secondTest.reading =  Int(sender.value)
                secondReadingLabel.text = "\(K.READING): \(secondReadings[score.secondTest.reading])"
            }
            secondScore.text = "+ \(score.secondTestToScore())"
        }
    }
    
    @IBAction func secondWritingChanged(_ sender: UIStepper) {
        if let score = score {
            try! realm.write {
                score.secondTest.writing =  Int(sender.value)
                secondWritingLabel.text = "\(K.WRITING): \(secondWritings[score.secondTest.writing])"
            }
            secondScore.text = "+ \(score.secondTestToScore())"
        }
    }
    
    // MARK: - Switch Control
    
    @IBAction func haveSeconLanguageChanged(_ sender: UISwitch) {
        secondLanguageView.isHidden.toggle()
        secondScoreView.isHidden.toggle()
        if let score = score {
            try! realm.write {
                score.haveSecondLanguage = sender.isOn
            }
            if sender.isOn {
                for i in 0..<secondTests.count {
                    secondLanguageSegmentedControl.setTitle(secondTests[i].name, forSegmentAt: i)
                }
                
                secondSpeakingLabel.text = "\(K.SPEAKING): \(secondSpeakings[score.secondTest.speaking])"
                secondListeningLabel.text = "\(K.LISTENING): \(secondListenings[score.secondTest.listening])"
                secondReadingLabel.text = "\(K.READING): \(secondReadings[score.secondTest.reading])"
                secondWritingLabel.text = "\(K.WRITING): \(secondWritings[score.secondTest.writing])"
                
                secondScore.text = "+ \(score.secondTestToScore())"
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom), animated: true)
            } else {
                scrollView.setContentOffset(.zero, animated: true)
            }
            secondTestView.backgroundColor = sender.isOn ? UIColor.white : UIColor(named: K.BACKGROUND)
        }
        scrollView.isScrollEnabled.toggle()
    }
    // MARK: - Segmented Control
    
    @IBAction func firstLanguageChanged(_ sender: UISegmentedControl) {
        if let score = score {
            try! realm.write {
                score.firstTest.selectedTest = sender.selectedSegmentIndex
            }
            
            speakingLabel.text = "\(K.SPEAKING): \(speakings[score.firstTest.speaking])"
            listeningLabel.text = "\(K.LISTENING): \(listenings[score.firstTest.listening])"
            readingLabel.text = "\(K.READING): \(readings[score.firstTest.reading])"
            writingLabel.text = "\(K.WRITING): \(writings[score.firstTest.writing])"
            
            if haveSecondLanguageSwitch.isOn {
                for i in 0..<secondTests.count {
                    secondLanguageSegmentedControl.setTitle(secondTests[i].name, forSegmentAt: i)
                }
                
                secondSpeakingLabel.text = "\(K.SPEAKING): \(secondSpeakings[score.secondTest.speaking])"
                secondListeningLabel.text = "\(K.LISTENING): \(secondListenings[score.secondTest.listening])"
                secondReadingLabel.text = "\(K.READING): \(secondReadings[score.secondTest.reading])"
                secondWritingLabel.text = "\(K.WRITING): \(secondWritings[score.secondTest.writing])"
            }
            
            firstScore.text = "+ \(score.firstTestToScore())"
        }
    }
    
    @IBAction func secondLanguageChanged(_ sender: UISegmentedControl) {
        if let score = score {
            try! realm.write {
                score.secondTest.selectedTest = sender.selectedSegmentIndex
            }
            secondSpeakingLabel.text = "\(K.SPEAKING): \(secondSpeakings[score.secondTest.speaking])"
            secondListeningLabel.text = "\(K.LISTENING): \(secondListenings[score.secondTest.listening])"
            secondReadingLabel.text = "\(K.READING): \(secondReadings[score.secondTest.reading])"
            secondWritingLabel.text = "\(K.WRITING): \(secondWritings[score.secondTest.writing])"
            
            secondScore.text = "+ \(score.secondTestToScore())"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ExperiencesViewController
        destination.score = score
    }
}
