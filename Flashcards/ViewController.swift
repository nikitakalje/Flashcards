//
//  ViewController.swift
//  Flashcards
//
//  Created by Nikita Kalje on 2/15/20.
//  Copyright © 2020 Nikita Kalje. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    
    //added these
    var extraOne: String
    var extraTwo: String
}

class ViewController: UIViewController {


    @IBOutlet weak var BackLabel: UILabel!

    @IBOutlet weak var FrontLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var optionOne: UIButton!
    
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    var flashcards = [Flashcard]()
    
    var currentIndex=0
    
    //button to remember which one is correct answer
    var correctAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //style
        card.layer.cornerRadius = 20.0
        //card.clipsToBounds = true
        card.layer.shadowRadius = 15.0

        card.layer.shadowOpacity = 0.2
        card.clipsToBounds = true
      
        prevButton.layer.cornerRadius = 20.0
        prevButton.layer.shadowRadius = 15.0
        prevButton.clipsToBounds = true
        
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.shadowRadius = 15.0
        nextButton.clipsToBounds = true
        
        optionOne.layer.cornerRadius = 20.0
        optionOne.layer.shadowRadius = 15.0
        optionOne.clipsToBounds = true
        
        optionTwo.layer.cornerRadius = 20.0
        optionTwo.layer.shadowRadius = 15.0
        optionTwo.clipsToBounds = true
        
        optionThree.layer.cornerRadius = 20.0
        optionThree.layer.shadowRadius = 15.0
        optionThree.clipsToBounds = true

        optionOne.layer.borderWidth = 3.0
        optionOne.layer.borderColor = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
        
        optionTwo.layer.borderWidth = 3.0
        optionTwo.layer.borderColor = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
        
        optionThree.layer.borderWidth = 3.0
        optionThree.layer.borderColor = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
       
        //Read saved flashcards
        readSavedFlashcards()
        
        //Adding our initial flashcard if needed
        if flashcards.count == 0 {
             updateFlashcard(question: "Antiderivative of e^x?", answer: "e^x", extraOne: "-e^x", extraTwo: "e^(-x)", isExisting: false)
            
           // updateFlashcard(question: "Antiderivative of e^x?", answer: "e^x", extraOne: "-e^x", extraTwo: "e^(-x)")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //initially make flashcard invisible, and slightly smaller
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        optionOne.alpha = 0.0
        optionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        optionTwo.alpha = 0.0
        optionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        optionThree.alpha = 0.0
        optionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
            
            self.optionOne.alpha = 1.0
                  self.optionOne.transform = CGAffineTransform.identity
                  
                  self.optionTwo.alpha = 1.0
                  self.optionTwo.transform = CGAffineTransform.identity
                  
                  self.optionThree.alpha = 1.0
                  self.optionThree.transform = CGAffineTransform.identity
                  
        })
        
            //  UIButton.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
        
          
        
       // })
    }

    @IBAction func didTapOnPrev(_ sender: Any) {
        //Decrease current index
        currentIndex = currentIndex - 1
        
        //Update labels
       // updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
        
        //just added
        animateCardOutPrev()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        //updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
        
    }
    
    @IBAction func didTapOne(_ sender: Any)
    {
        //optionOne.isHidden=true;
        
        //if is the correct answer, flip the flashcard
        //if not, disable the button, and hide the front label
        if optionOne == correctAnswerButton {
            flipFlashcard()
        }
        else {
            FrontLabel.isHidden = false
            optionOne.isEnabled = false
        }
    }
    
    @IBAction func didTapTwo(_ sender: Any)
    {
        //FrontLabel.isHidden=true;
       // flipFlashcard()
        
       // optionTwo.isHidden=true;
        
        //if is the correct answer, flip the flashcard
        //if not, disable the button, and hide the front label
        if optionTwo == correctAnswerButton {
            flipFlashcard()
        }
        else {
            FrontLabel.isHidden = false
            optionTwo.isEnabled = false
        }
    }
    
    @IBAction func didTapThree(_ sender: Any)
    {
       // optionThree.isHidden=true;
        
        //optionThree.isHidden=true;
        
        //if is the correct answer, flip the flashcard
        //if not, disable the button, and hide the front label
        if optionThree == correctAnswerButton {
            flipFlashcard()
        }
        else {
            FrontLabel.isHidden = false
            optionThree.isEnabled = false
        }
    }
    
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you would like to delete?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        
        present(alert, animated: true)
    }
    func deleteCurrentFlashcard(){
        
        //delete current flashcard
        flashcards.remove(at: currentIndex)
        
        //check if last card was deleted
        if currentIndex > flashcards.count-1
        {
            currentIndex = flashcards.count-1
       
        }
        if currentIndex == -1
        {
            currentIndex = 0
        }
        //print(currentIndex)
       // if currentIndex == 0
       // {
       //     currentIndex = 0
       // }
        
    updateNextPrevButtons()
      updateLabels()
        
     saveAllFlashcardsToDisk()
        
        
        
    }
    
    func flipFlashcard()
    {
       /* if(FrontLabel.isHidden==true)
        {
            FrontLabel.isHidden=false;
            BackLabel.isHidden=true;
        }
        else{
            FrontLabel.isHidden=true;
            BackLabel.isHidden=false;
        }*/

        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            //self.FrontLabel.isHidden = true
            
            if(self.FrontLabel.isHidden==true)
            {
                self.FrontLabel.isHidden=false;
                self.BackLabel.isHidden=true;
            }
            else{
                self.FrontLabel.isHidden=true;
                self.BackLabel.isHidden=false;
            }
        })

    }
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
           // self.animateCardIn()
            
            self.updateLabels()
            
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        
        //start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        //animate card going back to its original position
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity
        })
        
    }
    func animateCardOutPrev() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }, completion: { finished in
           // self.animateCardIn()
            
            self.updateLabels()
            
            self.animateCardInPrev()
        })
    }
    
    func animateCardInPrev() {
        
        //start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        //animate card going back to its original position
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity
        })
        
    }
    func updateFlashcard(question: String, answer: String, extraOne: String?, extraTwo: String?, isExisting: Bool)
    {
        let flashcard = Flashcard(question: question, answer: answer, extraOne: extraOne ?? "", extraTwo: extraTwo ?? "")// extraOne: (extraOne)? ?? , extraTwo: (extraTwo)?)
        FrontLabel.text=flashcard.question
        BackLabel.text=flashcard.answer
        
        optionOne.setTitle(extraOne, for: .normal)
        optionTwo.setTitle(answer, for: .normal)
        optionThree.setTitle(extraTwo, for: .normal)
        
        //to know if we should update existing card
       if isExisting
        {
            flashcards[currentIndex] = flashcard
        }

         else {
            flashcards.append(flashcard)
            
            print("Added new flashcard")
            print("We now have \(flashcards.count) flashcards")
            
            //update current index
            currentIndex=flashcards.count-1
            print("Our current index is \(currentIndex)")
        }
        

        //Update buttons
        updateNextPrevButtons()
        
        updateLabels()
    }
    func updateNextPrevButtons() {
        
        //Disable next button if at end
        if currentIndex == flashcards.count-1{
            nextButton.isEnabled=false
        }
        else {
            nextButton.isEnabled = true
        }
        
        //Disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled=false
        }
        else {
            prevButton.isEnabled=true
        }
    }
    func updateLabels() {
        
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update labels
        FrontLabel.text = currentFlashcard.question
        BackLabel.text = currentFlashcard.answer
        
        //just added
        FrontLabel.isHidden = false
        optionOne.isHidden = false
        optionTwo.isHidden = false
        optionThree.isHidden = false
        
        //update buttons
        let buttons = [optionOne, optionTwo, optionThree].shuffled()
        
        let answers = [currentFlashcard.answer, currentFlashcard.extraOne, currentFlashcard.extraTwo].shuffled()
        
        
        //iterate over both the arrays simultaneously
        for (button, answer) in zip(buttons, answers)
        {
            //setting title of this random button to a random answer
            button?.setTitle(answer, for: .normal)
            
            //added
            button?.isEnabled = true
            
            //if correct answer, save button
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
        
        //optionOne.setTitle(currentFlashcard.extraOne, for: .normal)
       // optionTwo.setTitle(currentFlashcard.answer, for: .normal)
       // optionThree.setTitle(currentFlashcard.extraTwo, for: .normal)
    
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        
        //added
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = FrontLabel.text
            
            creationController.initialAnswer = BackLabel.text
            
        }

        
    }
    
    func saveAllFlashcardsToDisk()
    {
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "Extra answer one": card.extraOne, "Extra answer two": card.extraTwo]
        }
        
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
        
        //Log it
        print("Flashcards saved to UserDefaults")
    }

    func readSavedFlashcards()
    {
        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]
        {
            //In here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraOne: dictionary["extra answer 1"]!, extraTwo: dictionary["extra answer 2"]!)
                
            }
            
            //Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
}
