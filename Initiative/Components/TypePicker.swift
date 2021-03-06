//
//  SegmentedPicker.swift
//  Initiative
//
//  Created by Sam Weiller on 5/12/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI

struct TypePicker: View {
    @Binding var selectedType: String
    
    var body: some View {
        HStack {
            Button(action: {
                self.selectedType = "Party"
            }) {
                Text("Party")
                    .pickerLabelStyle(isSelected: self.selectedType == "Party")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.all, 11)
                    .background(Color.white)
                    .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                    .foregroundColor(self.selectedType == "Party" ? Color("CorePurple") : Color("Low Emphasis Text"))
            }.buttonStyle(PlainButtonStyle())
            Spacer(minLength: 4)
            Button(action: {
                self.selectedType = "Enemy"
            }) {
                Text("Enemy")
                    .pickerLabelStyle(isSelected: self.selectedType == "Enemy")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.all, 11)
                    .background(Color.white)
                    .foregroundColor(self.selectedType == "Enemy" ? Color("CoreCoral") : Color("Low Emphasis Text"))
                
            }.buttonStyle(PlainButtonStyle())
            Spacer(minLength: 4)
            Button(action: {
                self.selectedType = "Ally"
            }) {
                Text("Ally")
                    .pickerLabelStyle(isSelected: self.selectedType == "Ally")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.all, 11)
                    .background(Color.white)
                    .cornerRadius(8, corners: [.topRight, .bottomRight])
                    .foregroundColor(self.selectedType == "Ally" ? Color("CoreTeal") : Color("Low Emphasis Text"))
                
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

func setCurrentValue(value: String) {
    
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
//        TypePicker(selectedType: "Enemy")
        Text("Hello")
    }
}


