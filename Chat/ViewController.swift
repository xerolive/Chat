//
//  ViewController.swift
//  Chat
//
//  Created by Smart on 2019/12/20.
//  Copyright © 2019 Smart. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
        
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        self.ref.observe(DataEventType.childAdded, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
          print(postDict)
            if let name = postDict["name"] as? String, let message = postDict["message"] as? String {
                let text = self.textView.text
                let add = name + ":" + message
                self.textView.text = (text ?? "") + "\n" + add
            }
        })
        
    }

    @IBAction func didTapSendButton(_ sender: Any) {
        
        if let name = nameTextField.text, let message = messageTextField.text {
            let messageData = [
                "name" : name,
                "message" : message
            ]
            self.ref.childByAutoId().setValue(messageData)
        }
        

    }
    
}

