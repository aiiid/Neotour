//
//  StepperViewModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

import Foundation

class StepperViewModel {
    var value: Int = 1 {
        didSet {
            onValueChange?(value)
        }
    }
    
    var onValueChange: ((Int) -> Void)?
    
    func increment() {
        if value < 5 {
            value += 1
        }
    }
    
    func decrement() {
        if value > 1 {
            value -= 1
        }
    }
}
