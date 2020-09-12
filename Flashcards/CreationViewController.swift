//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Nikita Kalje on 3/5/20.
//  Copyright © 2020 Nikita Kalje. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
  
    //CHANGED DEBUG1
    var questionText: String = "Question"
    var answerText: String = "Answer"
    

    @IBOutlet weak var questionTextField: UITextField!
    
    
    @IBOutlet weak var answerTextField: UITextField!
    
    
    @IBOutlet weak var extraOne: UITextField!
    
    @IBOutlet weak var extraTwo: UITextField!
    
    //is ok if there are no initial values
    //TOOK OUT2
    var initialQuestion: String?
    var initialAnswer: String?
    
    //ADDED DEBUG1
    //var initialExtraOne: String?
   // var initialExtraTwo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        
        
        //debug1
        //questionTextField.text = "question"
      //  answerTextField.text = "answer"
       // extraTwo.text = "extra answer 2"
      //  extraOne.text = "extra answer 1"
       // extraOne.text = initialExtraOne
        //extraTwo.text = initialExtraTwo
    }

    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        //TOOK OUT2
       let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        //added DEBUG1
        //let extraOneText = extraOne.text
       // let extraTwoText = extraTwo.text
        
        //check if is empty
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty
        {
            let alert = UIAlertController(title: "Missing Text", message: "Both Question and Answer is required!", preferredStyle: UIAlertController.Style .alert)
            
            present(alert, animated: true)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        else
        {
            var isExisting = false
            
            if initialQuestion != nil
            {
                isExisting = true
            }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraOne: extraOne.text!, extraTwo: extraTwo.text!, isExisting: isExisting)
            //flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraOne: extraOneText!, extraTwo: extraTwoText!, isExisting: isExisting)
          //  flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraOne: "Extra Answer 1", extraTwo: "Extra Answer 2")
            dismiss(animated: true)

        }
        
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
