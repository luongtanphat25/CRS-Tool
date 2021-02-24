//
//  LaunchViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-23.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
        image.layer.cornerRadius = image.frame.width/2
        label.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var charIndex = 0.0
        for c in K.LABEL {
            Timer.scheduledTimer(withTimeInterval: 0.05 * charIndex, repeats: false) { _ in
                self.label.text?.append(c)
            }
            charIndex += 1
        }
        
        UIView.animate(withDuration: 0.75, delay: 2) {
            self.view.backgroundColor = .white
        } completion: { _ in
            self.performSegue(withIdentifier: "toStart", sender: self)
        }

    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
