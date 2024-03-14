//
//  LeftAligned.swift
//  SwiftUIDemo
//
//  Created by Mayur Rangari on 08/03/24.
//

import SwiftUI

struct LeftAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
                .padding(.leading)
            Spacer()
        }
    }
}

extension View {
    func leftAligned() -> some View {
        return self.modifier(LeftAligned())
    }
}
