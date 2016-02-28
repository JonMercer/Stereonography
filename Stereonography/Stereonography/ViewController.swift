//
//  ViewController.swift
//  Stereonography
//
//  Created by Odin on 2016-02-27.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

import UIKit

import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var InsertLink: UITextField!
    
    @IBAction func Submit(sender: UIButton) {
        
        
        let linkstring = InsertLink.text
 
        let url = NSURL(fileURLWithPath: linkstring!)
        
      let amazonurl = NSURL(fileURLWithPath: "www.amazon.ca")
        
        if (url.host == amazonurl){
            
            
        }
        
        
  
        
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

