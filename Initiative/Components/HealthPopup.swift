//
//  HealthPopup.swift
//  Initiative
//
//  Created by Sam Weiller on 5/21/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import Introspect

struct HealthPopup: View {
    let creature: Creature
    let alertType: String // Damage, Heal, Initiative
    
    var typeIcon: String {
        switch alertType {
        case "Heal":
            return "bandage"
        case "Damage":
            return "burst"
        case "Initiative":
            return "hexagon"
        default:
            return ""
        }
    }
    
    @State var value: String = ""
    @Binding var showAlert: Bool
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                VStack(alignment: .leading) {
                    Text(creature.name ?? "Unknown").cardNameStyle()
                    Text(creature.type ?? "Unknown").cardTypeStyle()
                }
                Spacer()
                Text(creature.currentHP ?? "?").cardCurrentHPStyle()
                VStack(spacing: -1) {
                    Text("HP").cardHPLabelStyle()
                    Text("/\(creature.maxHP ?? "?")").cardMaxHPStyle()
                }
            }.padding([.horizontal])
            
            
            TextField("", text: $value)
                .introspectTextField { textField in
                    print("INTRO")
                    textField.becomeFirstResponder()
            }
            .textFieldStyle(FormTextFieldStyle())
            .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
            
            HStack {
                Button(action: {
                    print("canceling")
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.showAlert = false
                    }
                }) {
                    Image(systemName: "xmark")
                }
                .font(.custom("CircularStd-Bold", size: 16))
                .frame(width: 40, height: 40)
//                .padding(.all, 11)
                .background(Color("CoreDisabled"))
                .cornerRadius(8)
                .foregroundColor(.white)
                
                Spacer()
                Spacer()
                Button(action: {
                    self.moc.performAndWait {
                        self.creature.currentHP = addNumbers(first: self.creature.currentHP!, second: self.value)
                        try? self.moc.save()
                    }
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.showAlert = false
                    }
                }) {
                    HStack {
                        Image(systemName: "bandage")
                        Text("Heal")
                    }
                }
                .saveButtonStyle(type: "Heal")
                Button(action: {
                    self.moc.performAndWait {
                        self.creature.currentHP = subtractNumbers(first: self.creature.currentHP!, second: self.value)
                        try? self.moc.save()
                    }
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.showAlert = false
                    }
                }) {
                    HStack {
                        Image(systemName: "burst")
                        Text("Damage")
                    }
                }
                .saveButtonStyle(type: "Damage")
                
            }.padding(.top, 5)
        }.frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
    }
}

struct HealthPopup_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let coreDataObject = Creature(context: context)
        coreDataObject.name = "Goblin"
        coreDataObject.type = "Enemy"
        coreDataObject.initiative = "19"
        coreDataObject.maxHP = "30"
        coreDataObject.currentHP = "25"
        return ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            VStack(spacing: 15) {
                HealthPopup(creature: coreDataObject, alertType: "Heal", showAlert: .constant(true)).environment(\.managedObjectContext, context)
                
                HealthPopup(creature: coreDataObject, alertType: "Damage", showAlert: .constant(true)).environment(\.managedObjectContext, context)
                
                HealthPopup(creature: coreDataObject, alertType: "Health", showAlert: .constant(true)).environment(\.managedObjectContext, context)
            }.padding()
        }
    }
}

