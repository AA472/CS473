//
//  DetailViewController.swift
//  Periodic Table
//
//  Created by Aljandali, Abdullah on 9/23/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var appearance: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var boil: UILabel!
    @IBOutlet weak var melt: UILabel!
    @IBOutlet weak var density: UILabel!
    @IBOutlet weak var molarHeat: UILabel!
    @IBOutlet weak var electronConfiguration: UILabel!
    @IBOutlet weak var discoveredBy: UILabel!
    @IBOutlet weak var namedBy: UILabel!
    @IBOutlet weak var ContentView: UIView!
    
    
    var detailedElement: Element?

    func configureView() {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        if detailedElement != nil{
            symbol.text =  tryDisplaying(Object: detailedElement?.symbol)
            name.text = tryDisplaying(Object:detailedElement?.name)
            number.text = tryDisplaying(Object:detailedElement?.number) + " "
            mass.text = tryDisplaying(Object:detailedElement?.atomic_mass)
            
            let color: UIColor = UIColor.init(hex: (detailedElement?.color)!)!
            
            symbol.backgroundColor = color
            name.backgroundColor = color
            number.backgroundColor = color
            mass.backgroundColor = color
 
            summary.text = tryDisplaying(Object:detailedElement?.summary)
            appearance.text = tryDisplaying(Object:detailedElement?.appearance)
            category.text = tryDisplaying(Object:detailedElement?.category)
            boil.text = tryDisplaying(Object:detailedElement?.boil)
            melt.text = tryDisplaying(Object:detailedElement?.melt)
            density.text = tryDisplaying(Object:detailedElement?.density)
            molarHeat.text = tryDisplaying(Object:detailedElement?.molar_heat)
            electronConfiguration.text = tryDisplaying(Object:detailedElement?.electron_configuration)
            discoveredBy.text = tryDisplaying(Object:detailedElement?.discovered_by)
            namedBy.text = tryDisplaying(Object:detailedElement?.named_by)
            
            
    }
}
    
    func tryDisplaying(Object: Any?) -> String{
        if Object is String{
            return Object as! String
        }
        if Object is Int{
            return String(Object as! Int)
        }
        if Object is Double{
            return String(Object as! Double)
        }
        else{
            return "Unknown"
        }
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        print("Gets here")
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
