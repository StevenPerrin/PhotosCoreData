//
//  NewMealViewController.swift
//  PhotosCoreData
//
//  Created by Steven Perrin on 10/24/19.
//  Copyright © 2019 Steven Perrin. All rights reserved.
//

import UIKit

class NewMealViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    var meal: Meal?
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func save(_ sender: Any) {
//        guard let title = titleTextField.text else {
//            alertNotifyUser(message: "Could not save, make sure no fields are empty and a photo is selected")
//            return
//        }
        
        if titleTextField.text == "" || locationTextField.text == "" || mealImage.image == nil {
            alertNotifyUser(message: "Meal could not be saved, make sure no fields are empty")
            return
        }
        
        let mealTitle = titleTextField.text
        let mealLocation = locationTextField.text
        let selectedImage = mealImage.image
        
        if meal == nil {
            meal = Meal(title: mealTitle, location: mealLocation, image: selectedImage)
        } else {
            meal?.update(title: mealTitle ?? "Default", location: mealLocation ?? "Default", image: selectedImage!)
        }
        
        if let meal = meal {
            do {
                let managedContext = meal.managedObjectContext
                try managedContext?.save()
            } catch {
                alertNotifyUser(message: "meal could not be saved")
            }
        } else {
            alertNotifyUser(message: "meal could not be created")
        }
        navigationController?.popViewController(animated: true)
    }
    
    
//    @objc
//    func contactImageTapped(tapGesture: UITapGestureRecognizer) {
//        let alert = UIAlertController(title: "Select source", message: message, preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: #selector(NewMealViewController.takePicture())))
//        alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: #selector(NewMealViewController.selectPhoto())))
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
//
//        self.present(alert, animated: true, completion: nil)    }
    
    func takePicture() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            alertNotifyUser(message: "Camera could not be opened for this device.")
            return
        }
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    func selectPhoto() {
           guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
               alertNotifyUser(message: "Photo Library could not be opened.")
               return
           }
           
           imagePicker.sourceType = .photoLibrary
           imagePicker.delegate = self
           
           present(imagePicker, animated: true)
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer {
            picker.dismiss(animated: true)
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mealImage.image = image
            return
        }
        print("Image couldn't be opened")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        defer {
            picker.dismiss(animated: true)
        }
        print("Cancelled")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
