//
// LabeledTextField.swift
//  SwiftUIDemo
//
//  Created by Mayur Rangari on 08/03/24.
//

import SwiftUI

struct LabeledTextField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            TextField(placeholder, text: $text)
                .padding()
                .frame(height: CGFloat(40))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                )
        }
    }
}

struct LabeledTextView: View {
    var title: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            TextEditor(text: $text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(minHeight: 10) // Set minimum height for the text view
        }
    }
}


