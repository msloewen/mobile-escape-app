//
//  MainViewController.swift
//  Mobile Escape
//
//  Created by Mark S. Loewen on 2017-03-01.
//  Copyright © 2017 Paul Harvey. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //There has to be a series of hints and a key for each progress counter or it will crash.
    @IBOutlet var suspects: [UIButton]!
    @IBOutlet weak var console: UITextView!
    @IBOutlet weak var helpButton: UIButton!
    var consoleLines: [String] = ["Second task", "Third task", "Fourth task"]
    var hints: [[String]] = [["Check the drawer!", "The fingerprints match up!", "It's under your nose."],["Try harder!", "The soil sample name can be rearranged."],["Keep going!", "There's no place like home!", "The numbers correspond."], ["Yeehah!"]]
    var progressCounter: Int = 0
    var hintsCounter: Int = 0
    var finalTask: Bool = false
    var suspectArray: [Bool] = [false, false, false, false, false,
                                   false, false, false, false, false,
                                   false, false, false, false, false,
                                   false, false, false, false, false]
   
    var keys: [[Bool]] = [[false, false, false, false, true,
                        false, true, false, false, false,
                        false, false, false, false, false,
                        true, false, false, true, false],
                         
                         [true, false, false, true, true,
                          false, true, false, false, false,
                          false, true, true, false, false,
                          true, false, false, true, false],
                         
                         [true, false, false, true, true,
                          false, true, false, false, false,
                          true, true, true, false, true,
                          true, true, false, true, true],
        
                         [true, true, true, true, true,
                          false, true, true, false, true,
                          true, true, true, false, true,
                          true, true, false, true, true]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText(newText: "Welcome to the Binary Information Generating Suspect Identification System otherwise known as B.I.G. S.I.S.")
        updateText(newText: "Initializing...\n\nYour first task is to...")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressSuspect(_ sender: UIButton) {
        if finalTask == true {
            return
        }
        let buttonValue: String? = sender.titleLabel?.text
        let buttonInt: Int? = Int(buttonValue!)
        if suspectArray[buttonInt!] == false {
            suspectArray[buttonInt!] = true
            sender.setImage(#imageLiteral(resourceName: "Tagged"), for: .normal)
        }
        else{
            suspectArray[buttonInt!] = false
            sender.setImage(nil, for: .normal)
        }

        if keys.count > progressCounter && suspectArray == keys[progressCounter] {
                madeProgress()
        }
    }
    
    @IBAction func didPressReset(_ sender: Any) {
        for suspect in suspects {
            if suspect.isEnabled == true {
                suspect.setImage(nil, for: .normal)
            }
            //set to appropriate array of suspects
            if progressCounter == 0 {
                suspectArray = [false, false, false, false, false,
                                false, false, false, false, false,
                                false, false, false, false, false,
                                false, false, false, false, false]
            }
            else {
                suspectArray = keys[progressCounter-1]
            }
        }
    }
    
    @IBAction func didPressHint(_ sender: UIButton) {
        if (hintsCounter == hints[progressCounter].count) {
            updateText(newText: "There's no more hints!")
            sender.isEnabled = false
            return
        }
        updateText(newText: hints[progressCounter][hintsCounter])
        hintsCounter = hintsCounter + 1
    }
    
    //madeProgress is called after correct input is given
    func madeProgress() {
        for suspect in suspects {
            if suspect.currentImage == #imageLiteral(resourceName: "Tagged") {
                suspect.isEnabled = false
            }
        }
        if (progressCounter == consoleLines.count) {
            updateText(newText: "Final task!")
            finalTask = true
            //stop timer and trigger animation
            //for suspect in suspects {
            //    suspect.isEnabled = false
            //}
            return
        }
        updateText(newText: consoleLines[progressCounter])
        progressCounter = progressCounter + 1
        hintsCounter = 0
        helpButton.isEnabled = true
        
    }
    //updateText will be called at the beginning, when hint is pressed, and when correct input is given.
    func updateText(newText: String) {
        console.text.append("\(newText)\n\n")
        let range = NSMakeRange(console.text.characters.count - 1, 0)
        console.scrollRangeToVisible(range)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
