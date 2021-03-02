//
//  CanadianDegreeViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-06.
//

import UIKit
import RealmSwift


class CanadianDegreeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var haveCanadianDegreeSwitch: UISwitch!
    @IBOutlet weak var degreePicker: UIPickerView!
    @IBOutlet weak var totalView: UIView!
    
    @IBOutlet weak var degreeScore: UILabel!
    @IBOutlet weak var scoreView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        degreePicker.delegate = self
        degreePicker.dataSource = self
        
        if let score = score {
            haveCanadianDegreeSwitch.setOn(score.haveCanadianDegree, animated: true)
            degreeScore.text = "+ \(score.studyCanadaToScore())"
            if haveCanadianDegreeSwitch.isOn {
                degreePicker.isHidden = false
                degreePicker.selectRow(score.studyInCanada, inComponent: 0, animated: true)
            } else {
                degreePicker.isHidden = true
            }
            scoreView.isHidden = !score.haveCanadianDegree
            totalView.backgroundColor = score.haveCanadianDegree ? UIColor.white : UIColor(named: K.BACKGROUND)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            let row = degreePicker.selectedRow(inComponent: 0)
            try! realm.write {
                score.studyInCanada = haveCanadianDegreeSwitch.isOn ? row : score.studyInCanada
            }
        }
    }
    
    @IBAction func haveCanadianDegreeChanged(_ sender: UISwitch) {
        scoreView.isHidden = !sender.isOn
        if let score = score {
            try! realm.write { score.haveCanadianDegree = sender.isOn }
            degreePicker.isHidden.toggle()
            degreeScore.text = "+ \(score.studyCanadaToScore())"
            degreePicker.selectRow(score.studyInCanada, inComponent: 0, animated: true)
        }
        totalView.backgroundColor = sender.isOn ? UIColor.white :  UIColor(named: K.BACKGROUND)
    }
    
    // MARK: - Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.STUDY_IN_CANADA_LEVELS.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width-30, height: 80))
        title.text = K.STUDY_IN_CANADA_LEVELS[row]
        title.font = UIFont(name: "System", size: 17)
        title.textColor = UIColor(named: K.TEXT)
        title.numberOfLines = 0;
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let score = score {
            try! realm.write {
                score.studyInCanada = haveCanadianDegreeSwitch.isOn ? row : score.studyInCanada
            }
            degreeScore.text = "+ \(score.studyCanadaToScore())"
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LanguagesViewController
        destination.score = score
    }
}
