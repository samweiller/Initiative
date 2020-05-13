//
//  CustomFontHelper.swift
//  Initiative
//
//  Created by Sam Weiller on 5/13/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import Foundation
import SwiftUI

struct ViewTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 34))
            .foregroundColor(Color("Dark Text Primary"))
            .padding()
            .background(Color("MainBackground"))
    }
}

struct FormLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Bold", size: 16))
            .foregroundColor(Color("Dark Text Primary"))
            .padding(.bottom, 2)
    }
}

struct FormContent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 14))
            .foregroundColor(Color("Dark Text Primary"))
    }
}

struct TabViewLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("CircularStd-Book", size: 11))
            .foregroundColor(Color("Dark Text Primary"))
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



struct CustomStyleHelper_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
