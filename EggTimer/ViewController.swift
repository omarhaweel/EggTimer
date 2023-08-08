//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


class ViewController: UIViewController {
    // boiling times
    let eggTimes : [String: Int] = ["Soft" : 300, "Medium" : 420, "Hard": 720]
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer()
    var audioPlayer: AVAudioPlayer!

    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelector(_ sender: UIButton) {
        timer.invalidate() // invalidate any previous timers first
        
        let hardness : String! = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        loadSound()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
       
         
        
    }
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            
            progressBar.progress = Float(percentageProgress)
       
            
           
        }else {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
            
            
        }
    }
    
    func loadSound() {
        // Replace "soundFileName" with the actual name of your sound file
        if let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.prepareToPlay()
            } catch {
                print("Error loading sound: \(error.localizedDescription)")
            }
        }
    }
    
    func playSound(){
        if audioPlayer != nil{
            audioPlayer.play()
        }
    }

    

   
}
