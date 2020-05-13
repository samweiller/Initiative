//
//  AddCreatureView.swift
//  Initiative
//
//  Created by Sam Weiller on 5/12/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import Combine

struct AddCreatureView: View {
    @State var name: String = ""
    @State var creatureType: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var formSpacing: CGFloat = 5.0
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Add Creature")
                    .viewTitleStyle()
//                ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: formSpacing) {
                        Text("Name").formLabelStyle()
                        TextField("", text: $name)
                            .textFieldStyle(FormTextFieldStyle())
                    }.padding([.horizontal])
                    
                    VStack(alignment: .leading, spacing: formSpacing) {
                        Text("Type").formLabelStyle()
                        TypePicker().padding([.bottom])
                    }.padding([.horizontal])
                    
                    HStack {
                        VStack(alignment: .leading, spacing: formSpacing) {
                            Text("Max HP").formLabelStyle()
                            TextField("", text: $name).textFieldStyle(FormTextFieldStyle())
                        }.padding([.horizontal])
                        
                        VStack(alignment: .leading, spacing: formSpacing) {
                            Text("Current HP").formLabelStyle()
                            TextField("", text: $name).textFieldStyle(FormTextFieldStyle())
                        }.padding([.horizontal])
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: formSpacing) {
                            Text("Initiative").formLabelStyle()
                            TextField("", text: $name).textFieldStyle(FormTextFieldStyle())
                        }.padding([.horizontal])
                        
                        VStack(alignment: .leading, spacing: formSpacing) {
                            Text("Group").formLabelStyle()
                            TextField("", text: $name).textFieldStyle(FormTextFieldStyle())
                        }.padding([.horizontal])
                    }
                    HStack {
                        Button(action: {
                            print("button")
                        }) {
                            Text("Cancel")
                                .fontWeight(.bold)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.all, 11)
                                .cornerRadius(8)
                                .foregroundColor(.gray)
                            
                        }.padding([.horizontal])
                        Button(action: {
                            print("button")
                        }) {
                            Text("Save")
                                .fontWeight(.bold)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.all, 11)
                                .background(Color("CorePurple"))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                            
                        }.padding([.horizontal])
                    }.padding(.top)
                }
//                .padding(.bottom, keyboardHeight)
//                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
//                }
                Spacer()
            }
        }.background(Color("MainBackground").edgesIgnoringSafeArea(.all))
    }
}

struct AddCreatureView_Previews: PreviewProvider {
    static var previews: some View {
        AddCreatureView()
    }
}
