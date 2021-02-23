//
//  MaritalStatusViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-05.
//

import UIKit
import RealmSwift

class MaritalStatusViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var score: Score?
    let realm = try! Realm()
    
    @IBOutlet weak var maritalStatusPicker: UIPickerView!
    @IBOutlet weak var isPartnerCanadianLabel: UILabel!
    @IBOutlet weak var isPartnerCanadian: UISwitch!
    @IBOutlet weak var isWithPartnerLabel: UILabel!
    @IBOutlet weak var isWithPartner: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maritalStatusPicker.delegate = self
        maritalStatusPicker.dataSource = self
        
        if let score = score {
            maritalStatusPicker.selectRow(score.selectedMaritalStatus, inComponent: 0, animated: true)
            isPartnerCanadian.setOn(score.isPartnerCanadian, animated: true)
            isWithPartner.setOn(score.isWithPartner, animated: true)
            
            let row = maritalStatusPicker.selectedRow(inComponent: 0)
            if row == 1 || row == 4 {
                isPartnerCanadian.isHidden = false
                isPartnerCanadianLabel.isHidden = false
                isWithPartner.isHidden = false
                isWithPartnerLabel.isHidden = false
            } else {
                isPartnerCanadian.isHidden = true
                isPartnerCanadianLabel.isHidden = true
                isWithPartner.isHidden = true
                isWithPartnerLabel.isHidden = true
            }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let score = score {
            let row = maritalStatusPicker.selectedRow(inComponent: 0)
            do {
                try realm.write {
                    if row == 1 || row == 4 {
                        score.havePartner = (!score.isPartnerCanadian && score.isWithPartner) ? true : false
                    } else {
                        score.havePartner = false
                    }
                }
            } catch { print(error) }
        }
    }
    
    // MARK: - Switch changed value
    
    @IBAction func isPartnerCanadianChanged(_ sender: UISwitch) {
        if let score = score {
            do {
                try realm.write {
                    score.isPartnerCanadian = sender.isOn
                    isWithPartner.isHidden.toggle()
                    isWithPartnerLabel.isHidden.toggle()
                    score.isWithPartner = sender.isOn ? false : isWithPartner.isOn
                }
            } catch { print(error) }
        }
    }
    
    @IBAction func isWithPartnerChanged(_ sender: UISwitch) {
        if let score = score {
            do {
                try realm.write {
                    score.isWithPartner = sender.isOn
                }
            } catch { print(error) }
        }
    }
    
    // MARK: - Setup Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.MARITAL_STATUS.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        title.text = K.MARITAL_STATUS[row]
        title.font = UIFont(name: "System", size: 17)
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let score = score {
            do {
                try realm.write {
                    score.selectedMaritalStatus = row
                }
            } catch { print(error) }
            
            if row == 1 || row == 4 {
                isPartnerCanadian.isHidden = false
                isPartnerCanadianLabel.isHidden = false
                
                isWithPartner.isHidden = false
                isWithPartnerLabel.isHidden = false
                
                if isPartnerCanadian.isOn {
                    isWithPartner.isHidden = true
                    isWithPartnerLabel.isHidden = true
                } else {
                    isWithPartner.isHidden = false
                    isWithPartnerLabel.isHidden = false
                }
            } else {
                isPartnerCanadian.isHidden = true
                isPartnerCanadianLabel.isHidden = true
                isWithPartner.isHidden = true
                isWithPartnerLabel.isHidden = true
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AgeViewController
        destination.score = score
    }
}
