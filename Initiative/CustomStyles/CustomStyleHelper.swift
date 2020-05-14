//
//  CustomFontHelper.swift
//  Initiative
//
//  Created by Sam Weiller on 5/13/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import Foundation
import SwiftUI

// General Styles
struct ViewTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 34))
            .foregroundColor(Color("Text Primary"))
            .padding()
            .background(Color("MainBackground"))
    }
}

struct TabViewLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 11))
            .foregroundColor(Color("Text Primary"))
    }
}

// Form Styles
struct FormLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 16))
            .foregroundColor(Color("Text Primary"))
            .padding(.bottom, 2)
    }
}

struct FormContent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 14))
            .foregroundColor(Color("Text Primary"))
    }
}

struct PickerLabel: ViewModifier { // Color is commented out so the main view can control it better
    var selected: Bool
        
    func body(content: Content) -> some View {
        content
            .font(.custom(selected ? "CircularStd-Black" : "CircularStd-Medium", size: 14))
//            .foregroundColor(Color("Low Emphasis Text"))
    }
}

struct FormTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .formContentStyle()
            .padding(.all, 10)
            .background(Color("Text Field Background"))
            .cornerRadius(8)
            .disableAutocorrection(true)
    }
}

// Card Styles
struct CardInitValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Medium", size: 30))
//            .foregroundColor(Color("Text Primary"))
    }
}

struct CardNameStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Medium", size: 18))
            .foregroundColor(Color("Text Primary"))
    }
}

struct CardTypeStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 16))
            .foregroundColor(Color("Medium Emphasis Text"))
    }
}

struct CardCurrentHPStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 30))
            .foregroundColor(Color("Text Primary"))
    }
}

struct CardMaxHPStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 12))
            .foregroundColor(Color("Medium Emphasis Text"))
    }
}


struct CardHPLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 11))
            .foregroundColor(Color("Text Primary"))
    }
}


extension View {
    func viewTitleStyle() -> some View {
        self.modifier(ViewTitle())
    }
}

extension View {
    func formLabelStyle() -> some View {
        self.modifier(FormLabel())
    }
}

// Button style is same as label style. Just duplicating the extension
extension View {
    func formButtonStyle() -> some View {
        self.modifier(FormLabel())
    }
}

extension View {
    func formContentStyle() -> some View {
        self.modifier(FormContent())
    }
}

extension View {
    func pickerLabelStyle(isSelected: Bool) -> some View {
        self.modifier(PickerLabel(selected: isSelected))
    }
}

extension View {
    func tabViewLabelStyle() -> some View {
        self.modifier(TabViewLabel())
    }
}

extension View {
    func cardInitValueStyle() -> some View {
        self.modifier(CardInitValueStyle())
    }
}

extension View {
    func cardNameStyle() -> some View {
        self.modifier(CardNameStyle())
    }
}

extension View {
    func cardTypeStyle() -> some View {
        self.modifier(CardTypeStyle())
    }
}

extension View {
    func cardCurrentHPStyle() -> some View {
        self.modifier(CardCurrentHPStyle())
    }
}

extension View {
    func cardMaxHPStyle() -> some View {
        self.modifier(CardMaxHPStyle())
    }
}

extension View {
    func cardHPLabelStyle() -> some View {
        self.modifier(CardHPLabelStyle())
    }
}

struct CustomStyleHelper_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
