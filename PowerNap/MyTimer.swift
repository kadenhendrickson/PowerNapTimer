//
//  MyTimer.swift
//  PowerNap
//
//  Created by Kaden Hendrickson on 5/7/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation

//1) Write the protocol
protocol MyTimerDelegate: class {
    func timerSecondTicked()
    func timerCompleted()
    func timerStopped()
}

class MyTimer: NSObject {
    
    var timeRemaining: TimeInterval?
    var timer: Timer?
    
    //2) add weak var delegate
    weak var delegate: MyTimerDelegate?
    
    var isOn: Bool {
       return timeRemaining != nil
    }
    
    var timeAsString: String {
        let timeRemaining = Int(self.timeRemaining ?? 20 * 60)
        let minutesRemaining = timeRemaining/60
        let secondsRemaining = timeRemaining - ( minutesRemaining * 60 )
        return String(format: "%02d : %02d", arguments: [minutesRemaining, secondsRemaining])
    }
    
    func secondTick() {
        guard let timeRemaining = timeRemaining else { return }
        if timeRemaining > 0 {
            self.timeRemaining = timeRemaining - 1
            delegate?.timerSecondTicked()
            print(timeRemaining)
        } else {
            timer?.invalidate()
            self.timeRemaining = nil
            delegate?.timerCompleted()
        }
    }
    
    func startTimer(time: TimeInterval) {
        if !isOn {
            timeRemaining = time
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                    self.secondTick()
                })
            }
            
        }
    }
    
    func stopTimer() {
        if isOn {
            timeRemaining = nil
            timer?.invalidate()
            delegate?.timerStopped()
        }
    }
    
}
