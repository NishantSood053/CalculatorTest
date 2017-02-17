//
//  ViewController.swift
//  Calculator
//
//  Created by Nishant Sood on 2/17/17.
//  Copyright © 2017 Nishant Sood. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound : AVAudioPlayer!
    
    enum Operation : String
    {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        }catch let err as NSError
        {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    
    }
    
    @IBAction func numberPressed(sender: UIButton){
        
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: UIButton)
    {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMuliplyPressed(sender: UIButton)
    {
        processOperation(operation: Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: UIButton)
    {
        processOperation(operation: Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: UIButton)
    {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender : UIButton)
    {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender : UIButton)
    {
        processOperation(operation: .Clear)
    }

    
    func playSound()
    {
        if btnSound.isPlaying
        {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation : Operation){
    
        playSound()
        if currentOperation != Operation.Empty
        {
            if runningNumber != ""
            {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply
                {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Divide
                {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Subtract
                {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Add
                {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Clear
                {
                    resetCalculator()
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        }else
        {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
            if(currentOperation == Operation.Clear)
            {
                resetCalculator()
            }
        }
        
    }
    
    func resetCalculator()
    {
        currentOperation = Operation.Clear
        runningNumber = ""
        leftValStr = "0"
        rightValStr = "0"
        result = "0"
        outputLbl.text = result
    }
    

    

}

