//
//  String+Extensions.swift

//
//  Created by Alex on 01/03/2024.
//

import Foundation

extension String {
    var uppercasingFirst: String {
        prefix(1).uppercased() + dropFirst()
    }
}
