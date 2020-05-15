//
//  AutoFocusTextField.swift
//  Initiative
//
//  Created by Sam Weiller on 5/15/20.
//  Copyright © 2020 saweiller. All rights reserved.
//
// https://stackoverflow.com/questions/56507839/swiftui-how-to-make-textfield-become-first-responder

import Foundation
import SwiftUI

struct AutoFocusTextField: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<AutoFocusTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context:
        UIViewRepresentableContext<AutoFocusTextField>) {
        uiView.text = text
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: AutoFocusTextField

        init(_ autoFocusTextField: AutoFocusTextField) {
            self.parent = autoFocusTextField
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
