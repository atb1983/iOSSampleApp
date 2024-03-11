//
//  HoverButtonStyle.swift

//
//  Created by Alex on 01/03/2024.
//

import SwiftUI

struct HoverButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        // change the text color based on if it's disabled
        // make the button a bit more translucent when pressed
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        // make the button a bit smaller when pressed
        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
