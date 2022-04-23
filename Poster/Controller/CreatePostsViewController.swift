//
//  CreatePostsViewController.swift
//  Poster
//
//  Created by Akif Acar on 21.04.2022.
//

import UIKit

class CreatePostsViewController: UIViewController{
    
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var postImageView: UIImageView!
    
    //initialize imagePicker
    let imagePicker = UIImagePickerController()
    
    //the postViewController set the selectedUser property
    var selectedUser : User? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker.delegate = self
        bodyTextView.delegate = self
        
        
        configureImagaPicker()
        
        configureBodyTextView()
       
    }
    
    @IBAction func cameraButtonTouched(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    /**
    This method is used to add Done button to bodyTextView, set placeholder text and set font type and color of bodytextview.
    */
    func configureBodyTextView(){
        
        bodyTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        bodyTextView.text = K.placeholderTextBodyTextView
        bodyTextView.textColor = UIColor(named: "textcolorLight")
        bodyTextView.font = UIFont(name: K.fontTypeBodyTextView, size: K.fontSizeBodyTextView)!
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    /**
    This method is used to open camera if the app runs on iPhone otherwise open savedPhotoAlbum. Also, it prohibits picture editing.
    */
    func configureImagaPicker(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        imagePicker.allowsEditing = false
    }
   
    
    /**
    This method is used to add new post to the posts array of the singleton Postdata and alert the client if he does not enter a text
    */
    @IBAction func doneButtonTouched(_ sender: UIButton) {
        
        if !(bodyTextView.text == K.placeholderTextBodyTextView || bodyTextView.text.isEmpty){
            
            let newPost = Post(senderUserName: selectedUser!.userName, body: bodyTextView.text, postImage: postImageView.image!)
            PostData.sharedInstance.posts.append(newPost)
            navigationController?.popViewController(animated: true)
            
        }else{
            displayCustomAlertWith(message: K.alertViewMessage)
        }
    }
    
    /**
    This method is used to display custom alert to remind the client to enter some text
    - Parameter message: type 'String', the message that will be displayed in alertview
    */
    func displayCustomAlertWith(message: String){
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        alert.setMessage(font: UIFont(name: K.fontTypeAlertView, size: K.fontSizeAlertView)!, color: UIColor(named: "textColor")!)
        
        alert.setBackgroundColor(color: UIColor(named: "BackgroundLighter")!)
       
        self.present(alert, animated: true, completion: nil)
        
        //dismiss the alertview after sometime
        let when = DispatchTime.now() + 1.2
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
    }
    }
}

// MARK: imagePicker delegate methods

extension CreatePostsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            postImageView.image = userPickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
}

// MARK: bodyTextView delegate methods

extension CreatePostsViewController: UITextViewDelegate {
    
    //delete the placeholder text when the client begin editing.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(named: "textcolorLight") {
            textView.text = ""
            textView.textColor = UIColor(named: "textColor")
        }
    }
    
    //if the client enters nothing and end editing, get the placeholder text again
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = K.placeholderTextBodyTextView
            textView.textColor = UIColor(named: "textcolorLight")
        }
    }
}
