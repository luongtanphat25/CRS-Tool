//
//  ScoresTableViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-18.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ScoresTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    let realm = try! Realm()
    var scores: Results<Score>?
    
    override func viewWillAppear(_ animated: Bool) {
        loadScores()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: K.CELL)
        tableView.separatorStyle = .none
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        textField.autocapitalizationType = .words
        let alert = UIAlertController(title: K.ADD_PROFILE, message: K.ADD_MESSAGE, preferredStyle: .alert)
        let action = UIAlertAction(title: K.ADD, style: .default) { (action) in
            let newScore = Score()
            newScore.tests.append(TestResult())
            newScore.tests.append(TestResult())
            newScore.tests.append(TestResult())
            newScore.name = (textField.text != "") ? textField.text! : newScore.name
            self.saveScore(newScore: newScore)
            self.performSegue(withIdentifier: K.FROM_ADD, sender: self)
        }
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = K.PROFILE_PLACEHOLDER
            textField.autocapitalizationType = .words
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: K.CANCEL, style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CELL, for: indexPath) as! ProfileTableViewCell
        cell.delegate = self

        if let score = scores?[indexPath.row] {
            cell.crs.text = "\(score.finalScore)"
            cell.crs.backgroundColor = UIColor(named: setColor(score: score.finalScore))
            cell.name.text = score.name
            cell.age.text = "\(K.AGE): \(score.ageToScore())"
            cell.education.text = "\(K.EDUCATION): \(score.educationToScore())"
            cell.language.text = "\(K.LANGUAGE): \(score.firstTestToScore())"
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { [self] action, indexPath in
            if let deletedScore = scores?[indexPath.row] {
                try! self.realm.write {
                    realm.delete(deletedScore)
                }
            }
        }
        
        let editAction = SwipeAction(style: .default, title: nil) { [self] action, indexPath  in
            if let selectedScore = scores?[indexPath.row] {
                var textField = UITextField()
                textField.autocapitalizationType = .words
                let alert = UIAlertController(title: K.CHANGE_NAME, message: K.CHANGE_MESSAGE, preferredStyle: .alert)
                let action = UIAlertAction(title: K.SAVE, style: .default) { (action) in
                    try! self.realm.write {
                        selectedScore.name = (textField.text != "") ? textField.text! : selectedScore.name
                    }
                    tableView.deselectRow(at: indexPath, animated: true)
                    tableView.reloadData()
                }
                alert.addTextField { (field) in
                    textField = field
                    textField.placeholder = selectedScore.name
                    textField.autocapitalizationType = .words
                }
                alert.addAction(action)
                alert.addAction(UIAlertAction(title: K.CANCEL, style: .cancel, handler: { (action) in
                    tableView.deselectRow(at: indexPath, animated: true)
                    tableView.reloadData()
                }))
                present(alert, animated: true)
            }
        }
        
        deleteAction.image = UIImage(systemName: "trash.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        editAction.image = UIImage(systemName: "pencil.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        editAction.backgroundColor = UIColor(named: K.U4)
        return [deleteAction, editAction]
    }
    
    //SwipeOptions
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.FROM_CELL, sender: self)
    }
    
    // MARK: - Data Manipulation
    
    func loadScores() {
        scores = realm.objects(Score.self)
        tableView.reloadData()
    }
    
    func saveScore(newScore: Score) {
        do {
            try realm.write {
                realm.add(newScore)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
   
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.FROM_CELL {
            let destination = segue.destination as! MaritalStatusViewController
            let row = tableView.indexPathForSelectedRow!.row
            destination.score = scores![row]
        } else if segue.identifier == K.FROM_ADD {
            let destination = segue.destination as! MaritalStatusViewController
            destination.score = scores!.last
        }
    }
    
    func setColor(score: Int) -> String {
        switch score {
        case ...200:
            return K.U2
        case ...400:
            return K.U4
        case ...600:
            return K.U6
        case ...800:
            return K.U8
        default:
            return K.U
        }
    }
}
