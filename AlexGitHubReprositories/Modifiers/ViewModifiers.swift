//
//  ViewModifiers.swift
//
//  Created by Alex on 30/02/2024.
//

import SwiftUI

struct PrimaryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.appPrimary))
    }
}

struct SecondaryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.appSecondary))
    }
}

struct TernaryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.appTernary))
    }
}

struct HiperLinkTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(Color(.hyperlink))
    }
}
