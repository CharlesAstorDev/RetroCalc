//
//  ViewController.swift
//  RetroCalc
//
//  Created by Charles Astor on 6/10/17.
//  Copyright © 2017 Charles Astor. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var btnSound = AVAudioPlayer()
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var runningNumber = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var rightValue = ""
    var leftValue = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func multiply(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func divide(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func subtract(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func add(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func equal(sender: AnyObject){
        processOperation(operation: currentOperation)
    }

    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                //Do something
            result = "\(Double(leftValue)! * Double(rightValue)!)"
                
            }else if currentOperation == Operation.Divide{
                //to do
                result = "\(Double(leftValue)! / Double(rightValue)!)"
            }else if currentOperation == Operation.Add{
                result = "\(Double(leftValue)! + Double(rightValue)!)"
            }else if currentOperation == Operation.Subtract{
                result = "\(Double(leftValue)! - Double(rightValue)!)"
                
            }
                leftValue = result
                outputLbl.text = result
         }
            currentOperation = operation
        
        }
        else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

