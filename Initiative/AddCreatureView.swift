//
//  AddCreatureView.swift
//  Initiative
//
//  Created by Sam Weiller on 5/12/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import Combine
import Introspect

struct AddCreatureView: View {
    var modalType: String
    var sender: String
    @Binding var showModal: Bool
    var creature: Creature? = nil
    
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
                HStack {
                    Text(modalType == "new" ? "Add Creature" : "Edit Creature")
                        .viewTitleStyle()
                    Spacer()
                    Button(action: {
                        self.showModal = false
                    }) {
                    Text("Cancel")
                        .foregroundColor(Color(getColorFromType(type: self.creatureType)))
                        .padding(.trailing)
                    }
                }
                
                VStack {
                    VStack(alignment: .leading, spacing: formSpacing) {
                        Text("Name").formLabelStyle()
                        TextField("", text: $name)
                            .introspectTextField { textField in
                               textField.becomeFirstResponder()
                            }
                            .textFieldStyle(FormTextFieldStyle())
                        
                    }.padding([.horizontal])
                    
                    VStack(alignment: .leading, spacing: formSpacing) {
                        Text("Type").formLabelStyle()
                        TypePicker(selectedType: $creatureType).padding([.bottom])
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
                        if self.modalType == "new" {
                            EmptyView()
                        } else {
                            Button(action: {
                                self.moc.delete(self.creature!)
                                self.showModal = false
                            }) {
                                HStack {
                                    Image(systemName: "trash")
                                }
                            }.smallButtonStyle(type: "Delete")
                                .padding([.horizontal])
                        }
                        Button(action: {
                            var creatureObject: Creature
                            if self.modalType == "new" {
                                creatureObject = Creature(context: self.moc)
                                creatureObject.creatureID = UUID()
                            } else {
                                creatureObject = self.creature!
                            }
                            creatureObject.type = self.creatureType
                            creatureObject.name = self.name
                            creatureObject.maxHP = self.maxHP
                            if (self.maxHP != "" && self.currentHP == "") {
                                creatureObject.currentHP = self.maxHP
                            } else {
                                creatureObject.currentHP = self.currentHP
                            }
                            creatureObject.initiative = self.initiativeValue
                            
                            // Sets creature to "Live" if created in Initiative view
                            creatureObject.isLive = self.sender == "initiative"
                            
                            try? self.moc.save()
                            self.showModal = false
                        }) {
                            Text("Save")
                                .saveButtonStyle(type: self.creatureType == "" ? "Disabled" : self.creatureType)
                                .animation(.easeInOut(duration: 0.5))
                        }.padding([.horizontal])
                    }.padding(.top)
                }
                Spacer()
            }
        }.background(Color("MainBackground").edgesIgnoringSafeArea(.all))
            .onAppear{
                if self.creature != nil {
                    let c = self.creature!
                    self.name = c.name ?? ""
                    self.maxHP = c.maxHP ?? ""
                    self.currentHP = c.currentHP ?? ""
                    self.initiativeValue = c.initiative ?? ""
                    self.creatureType = c.type ?? ""
                }
        }
    }
}

struct AddCreatureView_Previews: PreviewProvider {
    static var previews: some View {
        AddCreatureView(modalType: "new", sender: "initiative", showModal: .constant(true))
    }
}
