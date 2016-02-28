//
//  AnswerQuestion.swift
//  Stereonography
//
//  Created by Karan Grover on 2016-02-28.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

import Foundation

import UIKit

import Foundation

class AnswerQuestion: UIViewController {
    
    @IBOutlet weak var Question: UILabel!
    //access cloud with link "SecureURL"
    // use omar 2 function to decrypt question
    
    
    @IBOutlet weak var AnswerHere: UITextField!
    
    //send this to omar and check if answer is Equal.to!!!!!!!
    // if so call omar3 with the image we get from the link!!!!!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSegueWithIdentifier("heresyourtext", sender: self)
    
    // DOES THIS GO HERE^
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

