//
//  URLViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 13.07.2022.
//

import UIKit
import WebKit

final class URLViewController: UIViewController {

    @IBOutlet weak var WVWEBview: WKWebView!
   
    var url = "http://www.apple.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: self.url)!)
            self.WVWEBview.load(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
