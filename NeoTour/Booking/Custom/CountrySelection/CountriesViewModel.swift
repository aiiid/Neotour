//
//  CountriesViewModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

import Foundation

class CountriesViewModel {
    private let countries: [Country] = [
        Country(flag: "🇰🇿", code: "+77"), 
        Country(flag: "🇺🇸", code: "+1"),  
        Country(flag: "🇨🇦", code: "+1"),  
        Country(flag: "🇷🇺", code: "+7"),  
        Country(flag: "🇰🇬", code: "+996"),
        Country(flag: "🇺🇿", code: "+998"),
        Country(flag: "🇦🇪", code: "+971"),
        Country(flag: "🇩🇪", code: "+49"), 
        Country(flag: "🇫🇷", code: "+33"), 
        Country(flag: "🇮🇹", code: "+39")]
    
    var numberOfCountries: Int {
        return countries.count
    }
    
    func country(at index: Int) -> Country {
        return countries[index]
    }
}
