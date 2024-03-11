//
//  Color+Hex.swift

//
//  Created by Alex on 01/03/2024.
//

import SwiftUI
// Hex colors
extension Color {
    public init(hex: String) {
        var finalHexColor = hex
        
        if hex.hasPrefix("#") {
            // removing # symbol
            let start = finalHexColor.index(finalHexColor.startIndex, offsetBy: 1)
            finalHexColor = String(finalHexColor[start...])
        }
        
        // adds default transparency
        if finalHexColor.count == 6 {
            finalHexColor.append("FF")
        }
        
        self.init(Color.scanHexColor(hexColor: finalHexColor))
    }
    
    private static func scanHexColor(hexColor: String) -> UIColor {
        let r, g, b, a: CGFloat
        
        if hexColor.count >= 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                
                return UIColor(red: r, green: g, blue: b, alpha: a)
            }
        }
        
        return UIColor.black
    }
}
