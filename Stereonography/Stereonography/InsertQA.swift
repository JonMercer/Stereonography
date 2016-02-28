//
//  InsertQA.swift
//  Stereonography
//
//  Created by Karan Grover on 2016-02-28.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

import UIKit

import Foundation

class InsertQA: UIViewController {
    
    @IBOutlet weak var YourQuestion: UITextField!
    
    
    
    @IBOutlet weak var YourAnswer: UITextField!
    
    
    @IBAction func SubmitQA(sender: UIButton) {
        
        
        
        let defaultQ = NSUserDefaults.standardUserDefaults()
        defaultQ.setObject("YourQuestion", forKey: "MadeQuestion")
        
        let defaultA = NSUserDefaults.standardUserDefaults()
        defaultA.setObject("YourAnswer", forKey: "MadeAnswer")

        performSegueWithIdentifier("loadingscreen", sender: self)
        
        
        
        // a function giving omar this question and answer would go here with "MadeQuestion" "MadeAnswer" "MessageData"
        // Send result to server copy link
        
    }
    
override func viewDidLoad() {
    super.viewDidLoad()
    

}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}


