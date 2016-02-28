//
//  ViewController.swift
//  Stereonography
//
//  Created by Odin on 2016-02-27.
//  Copyright © 2016 Purple Octopus. All rights reserved.
//

import UIKit

import Foundation

class TakePicture: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var ImageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    @IBAction func TakePicture(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        // Dispose of any resources that can be recreated.
    }
    
    
}

