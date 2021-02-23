//
//  EducationViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-05.
//

import UIKit
import RealmSwift

class EducationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var educationLevelPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        educationLevelPicker.delegate = self
        educationLevelPicker.dataSource = self
        
        if let score = score {
            educationLevelPicker.selectRow(score.education, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            try! realm.write {
                score.education = educationLevelPicker.selectedRow(inComponent: 0)
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
            try! realm.write { score.education = row }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CanadianDegreeViewController
        destination.score = score
    }
}
