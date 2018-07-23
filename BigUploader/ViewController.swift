//
//  ViewController.swift
//  BigUploader
//
//  Created by Mehdi on 4/1/18.
//  Copyright © 2018 Mehdi. All rights reserved.

import UIKit
import MobileCoreServices
import Firebase

class ViewController:UIViewController {
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var messageLabel: UILabel!
    let userID = Auth.auth().currentUser?.uid
    let importDate = SmallFunctions()
    var storageRef: StorageReference{
        return Storage.storage().reference().child(userID!).child("CapsulateReturn").child("AmazonReturnLabel")
    }
    var documenteRef: DocumentReference! {
        return Firestore.firestore().document("Users/\(userID!)/AmazonReturnLabels/\(importDate.giveDate())")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadButtonWasPressed(_ sender: UIButton) {
        messageLabel.text = ""
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypePDF as String]
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func uploadImageToFirebaseStorage(data: Data){
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        let uploadTask = storageRef.putData(data as Data, metadata: uploadMetadata) { (metadata, error) in
            if(error != nil){
                self.messageLabel.text = "There seems to be a problem"
                print("I have received an error\(String(describing: error?.localizedDescription))")
            } else {
                self.messageLabel.text = "Upload Completed!"
                print("Upload Completed! Please take a look at these metadata!\(String(describing: metadata))")
                print(metadata?.downloadURL()! ?? "Nothing")
                let dataToSave : [String: String] = ["date": (metadata?.downloadURL()?.absoluteString)!]
                print("This is it I guess: \(dataToSave)")
                self.documenteRef.setData(dataToSave)
                
            }
        }
        //Update the progress bar as the image gets updated
        uploadTask.observe(.progress) { [weak self] (snapshot) in
            guard let strongSelf = self else {return}
            guard let progress = snapshot.progress else {return}
            strongSelf.progressBar.progress = Float(progress.fractionCompleted)
        }
    }
    
    func uploadPDFToFirebaseStorage(url: NSURL) {
        //Fix me
        
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        guard let mediaType: String = info[UIImagePickerControllerMediaType] as? String else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        if mediaType == (kUTTypeImage as String){
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage, let imageData = UIImageJPEGRepresentation(originalImage, 0.8) {
                uploadImageToFirebaseStorage(data: imageData)
            }
        } else if mediaType == (kUTTypePDF as String){
            if let pdfURL = info[UIImagePickerControllerMediaURL] as? NSURL{
                uploadPDFToFirebaseStorage(url: pdfURL as NSURL)
            }
            
        }
        
        
        dismiss(animated: true, completion: nil)
        
    
    }
    
}
