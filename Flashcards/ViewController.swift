//
//  ViewController.swift
//  Flashcards
//
//  Created by Nikita Kalje on 2/15/20.
//  Copyright © 2020 Nikita Kalje. All rights reserved.
//

import UIKit

class ViewController: UIViewController {




    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    @IBOutlet weak var BackLabel: UILabel!

    @IBOutlet weak var FrontLabel: UILabel!


    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        FrontLabel.isHidden=true;
    }
    func updateFlashcard(question: String, answer: String)
    {
        FrontLabel.text=question;
        BackLabel.text=answer;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    
}

