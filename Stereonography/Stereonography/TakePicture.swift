//
//  ViewController.swift
//  Stereonography
//
//  Created by Odin on 2016-02-27.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

import UIKit

class TakePicture: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var introModalDidDisplay = false
    
    @IBOutlet var ImageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if (!introModalDidDisplay) {
            introModalDidDisplay = true;
            imagePicker = UIImagePickerController(); imagePicker.delegate = self; imagePicker.sourceType = .Camera;
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        ImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        saveImage();
    }
    
    func saveImage() {
        let imagedefaults = NSUserDefaults.standardUserDefaults()
        imagedefaults.setObject("info", forKey: "imagestorage")
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        performSegueWithIdentifier("makeqa", sender: self)

    }
    
    
}

