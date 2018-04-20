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
    
    @IBAction func uploadButtonWasPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypePDF as String, kUTTypeImage as String]
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func uploadImageToFirebaseStorage(data: Data){
        //Fix me
    }
    
    func uploadPDFToFirebaseStorage(url: URL) {
        //Fix me
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]){
        guard let mediaType: String = info[UIImagePickerControllerMediaType] as? String else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        if mediaType == (kUTTypeImage as String){
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage, let imageData = UIImageJPEGRepresentation(originalImage, 0.8) {
                uploadImageToFirebaseStorage(data: imageData)
            }
        } else if mediaType == (kUTTypePDF as String){
            if let pdfURL = info[UIImagePickerControllerMediaURL] as? URL{
                uploadPDFToFirebaseStorage(url: pdfURL as URL)
            }
            
        }
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
}

