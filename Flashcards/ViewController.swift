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
    
}
