//
//  ViewController.swift
//  BigUploader
//
//  Created by Mehdi on 4/1/18.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit
import MobileCoreServices


class ViewController: UIViewController {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func uploadButoonWasPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypePDF as String, kUTTypeImage as String]
        imagePicker.delegate = self
        presentedViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func uploadImageToFirebaseStorage(data: NSData){
        
    }
    
    func uploadPDFToFirebaseStorage(url: NSURL) {
        
    }
    
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func imagePickerControllerDidCancel(picker: UIImagePickerController){
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]){
        guard let mediaType: String = info[UIImagePickerControllerMediaType] as? String else {
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
    }
    
    if mediaType == (kUTTypeImage as String){
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage, uploadImageToFirebaseStorage9imagedata)
    } else if {
    mediaType ==(kUTTypePDF as String){
    if letPDFURL = info[UIImagePickerControllerMediaURL] as? NSURL{
    uploadPDFToFirebaseStrorage(PDFURL)
    }
    
    }
    
    
    
    
    
    }
    
    
    
    
    
    }

}

