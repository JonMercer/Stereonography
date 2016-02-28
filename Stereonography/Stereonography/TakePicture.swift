import UIKit

class TakePicture: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageViewer: UIImageView!
    
    @IBAction func presentImagePicker(sender: AnyObject) {
        
        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerControllerCameraDevice.Front) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIImagePickerController.isCameraDeviceAvailable(   UIImagePickerControllerCameraDevice.Front) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            print("no front camera available")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(true, completion: nil)
        imageViewer.image = image
    }
}