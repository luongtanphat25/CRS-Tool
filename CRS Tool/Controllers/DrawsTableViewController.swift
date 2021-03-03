//
//  DrawsTableViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-03-02.
//

import UIKit
import FirebaseFirestore

class DrawsTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    var draws: [Draw] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: K.CELL)
        tableView.separatorStyle = .none
        loadDraws()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return draws.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CELL, for: indexPath) as! ProfileTableViewCell
        
        let draw = draws[indexPath.row]
        cell.crs.text = "\(draw.score)"
        cell.crs.backgroundColor = UIColor(named: setColor(score: draw.score))
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
        cell.name.text = dateFormatterPrint.string(from: draw.date)
        
        cell.age.text = "\(K.INVITATIONS) \(draw.invitations)"
        cell.education.text = ""
        cell.language.text = ""
        
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func loadDraws() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.date, descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                self.draws = []
                if let e = error {
                    print(e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let score = data[K.FStore.score] as? Int,
                               let invitations = data[K.FStore.invitations] as? Int,
                               let dateTimestamp = data[K.FStore.date] as? Timestamp {
                                let newDraw = Draw(score: score, date: dateTimestamp.dateValue(), invitations: invitations)
                                self.draws.append(newDraw)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
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
