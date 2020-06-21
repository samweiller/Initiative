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

struct SmallerTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 24))
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

struct SaveButtonStyle: ViewModifier {
    var type: String
    
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 16))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.all, 11)
            .background(Color(getColorFromType(type: type)))
            .cornerRadius(8)
            .foregroundColor(type == "Cancel" ? .gray : .white)
    }
}

struct SmallCancelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 16))
            .frame(width: 40, height: 40)
            .background(Color("CoreDisabled"))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}

struct SmallButtonStyle: ViewModifier {
    var type: String
    
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 16))
            .frame(width: 40, height: 40)
            .background(Color(getColorFromType(type: type)))
            .cornerRadius(8)
            .foregroundColor(.white)
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

struct NavBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 17))
            .foregroundColor(Color("CorePurple"))
    }
}

struct CardCurrentHPStyle: ViewModifier {
    var level: String
    
    var theColor: Color {
        switch level {
        case "healthy":
            return Color("Text Primary")
        case "hurting":
            return Color("CoreCoral")
        case "dying":
            return Color("DamageRed")
        default:
            return Color("Text Primary")
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 30))
            .foregroundColor(theColor)
    }
}

struct CardMaxHPStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 14))
            .foregroundColor(Color("Medium Emphasis Text"))
    }
}

struct CardHPLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 12))
            .foregroundColor(Color("Text Primary"))
    }
}

struct ActionIconStyle: ViewModifier {
    let font = Font.system(size: 22).weight(.semibold)
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(Color("Medium Emphasis Text"))
            .frame(width: 24, height: 24)
    }
}


extension View {
    func viewTitleStyle() -> some View {
        self.modifier(ViewTitle())
    }
}

extension View {
    func smallerTitleStyle() -> some View {
        self.modifier(SmallerTitle())
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
    func navBarStyle() -> some View {
        self.modifier(NavBarStyle())
    }
}

extension View {
    func cardCurrentHPStyle(level: String) -> some View {
        self.modifier(CardCurrentHPStyle(level: level))
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

extension View {
    func actionIconStyle() -> some View {
        self.modifier(ActionIconStyle())
    }
}

extension View {
    func saveButtonStyle(type: String) -> some View {
        self.modifier(SaveButtonStyle(type: type))
    }
}

extension View {
    func smallButtonStyle(type: String) -> some View {
        self.modifier(SmallButtonStyle(type: type))
    }
}

extension View {
    func smallCancelStyle() -> some View {
        self.modifier(SmallCancelStyle())
    }
}

struct CustomStyleHelper_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
