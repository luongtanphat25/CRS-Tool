//
//  DrawsViewController.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-18.
//

import UIKit
import WebKit

class DrawsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: K.URL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
