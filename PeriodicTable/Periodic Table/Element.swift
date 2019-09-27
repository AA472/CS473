//
//  Element.swift
//  Periodic Table
//
//  Created by Aljandali, Abdullah on 9/26/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import Foundation

struct Elements: Decodable {
    let elements: [Element]
}
struct Element : Decodable {
    
    let name : String?
    let appearance : String?
    let atomic_mass : Double?
    let boil : Double?
    let category : String?
    let color: String?
    let density: Double?
    let discovered_by : String?
    let melt : Double?
    let molar_heat : Double?
    let named_by : String?
    let number : Int?
    let period : Int?
    let phase : String?
    let source : String?
    let spectral_img : String?
    let summary : String?
    let symbol : String?
    let xpos : Int?
    let ypos: Int?
    let shells : [Int]?
    let electron_configuration : String?
    let electron_affinity : Double?
    let electronegativity_pauling : Double?
    let ionization_energies : [Double]? 
}
