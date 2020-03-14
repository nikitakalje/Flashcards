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
}

class ViewController: UIViewController {


    @IBOutlet weak var BackLabel: UILabel!

    @IBOutlet weak var FrontLabel: UILabel!
    
    var flashcards = [Flashcard]()
    
    var currentIndex=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Read saved flashcards
        readSavedFlashcards()
        
        //Adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //Decrease current index
        currentIndex = currentIndex - 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(FrontLabel.isHidden==true)
        {
            FrontLabel.isHidden=false;
            BackLabel.isHidden=true;
        }
        else{
            FrontLabel.isHidden=true;
            BackLabel.isHidden=false;
        }
        
    }
    func updateFlashcard(question: String, answer: String)
    {
        let flashcard = Flashcard(question: question, answer: answer)
        FrontLabel.text=flashcard.question
        BackLabel.text=flashcard.answer
        
        flashcards.append(flashcard)
        
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        //update current index
        currentIndex=flashcards.count-1
        print("Our current index is \(currentIndex)")
        

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
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    func saveAllFlashcardsToDisk()
    {
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
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
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                
            }
            
            //Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
}
