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
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var degreePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        degreePicker.delegate = self
        degreePicker.dataSource = self
        
        if let score = score {
            haveCanadianDegreeSwitch.setOn(score.haveCanadianDegree, animated: true)
            
            if haveCanadianDegreeSwitch.isOn {
                degreeLabel.isHidden = false
                degreePicker.isHidden = false
                degreePicker.selectRow(score.studyInCanada, inComponent: 0, animated: true)
            } else {
                degreeLabel.isHidden = true
                degreePicker.isHidden = true
            }
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
        if let score = score {
            try! realm.write { score.haveCanadianDegree = sender.isOn }
            degreeLabel.isHidden.toggle()
            degreePicker.isHidden.toggle()
            degreePicker.selectRow(score.studyInCanada, inComponent: 0, animated: true)
        }
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
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width - 30, height: 50))
        title.text = K.STUDY_IN_CANADA_LEVELS[row]
        title.font = UIFont(name: "System", size: 17)
        title.lineBreakMode = .byWordWrapping;
        title.numberOfLines = 0;
        title.sizeToFit()
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let score = score {
            try! realm.write {
                score.studyInCanada = haveCanadianDegreeSwitch.isOn ? row : score.studyInCanada
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LanguagesViewController
        destination.score = score
    }
}
