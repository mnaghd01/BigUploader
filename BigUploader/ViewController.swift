//
//  ViewController.swift
//  BigUploader
//
//  Created by Mehdi on 4/1/18.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit
import MobileCoreServices
import Firebase


class ViewController:UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
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
        let storageRef = Storage.storage().reference(withPath: "CapsulateReturn/AmazonReturnLabel")
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        let uploadTask = storageRef.putData(data as Data, metadata: uploadMetadata) { (metadata, error) in
            if(error != nil){
                print("I have received an error\(String(describing: error?.localizedDescription))")
            } else {
                print("Upload Completed! Please take a look at these metadata!\(String(describing: metadata))")
            }
        }
        //Update the progress bar as the image gets updated
        uploadTask.observe(.progress) { [weak self] (snapshot) in
            guard let strongSelf = self else {return}
            guard let progress = snapshot.progress else {return}
            strongSelf.progressBar.progress = Float(progress.fractionCompleted)
        }
    }
    
    func uploadPDFToFirebaseStorage(url: URL) {
        //Fix me
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]){
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

