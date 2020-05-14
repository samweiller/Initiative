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
    @State var maxHP: String = "" 
    @State var currentHP: String = ""
    @State var initiativeValue: String = ""
    @State var creatureGroup: String = ""
    
    @State var creatureType: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    @Environment(\.managedObjectContext) var moc
    
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
                            TextField("", text: $maxHP, onEditingChanged: {_ in
                                if (self.currentHP == "") {
                                    self.currentHP = self.maxHP
                                }
                            }
                            ).textFieldStyle(FormTextFieldStyle())
                                .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
                        }.padding([.horizontal])
                        
                        VStack(alignment: .leading, spacing: formSpacing) {
                            Text("Current HP").formLabelStyle()
                            TextField("", text: $currentHP).textFieldStyle(FormTextFieldStyle())
                            .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
                        }.padding([.horizontal])
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: formSpacing) {
                            Text("Initiative").formLabelStyle()
                            TextField("", text: $initiativeValue).textFieldStyle(FormTextFieldStyle())
                            .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
                        }.padding([.horizontal])
                        
                        VStack(alignment: .leading, spacing: formSpacing) {
                            Text("Group").formLabelStyle()
                            TextField("", text: $creatureGroup).textFieldStyle(FormTextFieldStyle())
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
                            let creature = Creature(context: self.moc)
                            creature.type = "Party"
                            creature.name = self.name
                            creature.totalHP = Int16(self.maxHP)!
                            creature.currentHP = Int16(self.currentHP)!
                            creature.initiative = Int16(self.initiativeValue)!
                            try? self.moc.save()

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
