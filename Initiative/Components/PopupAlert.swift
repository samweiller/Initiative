//
//  PopupAlert.swift
//  Initiative
//
//  Created by Sam Weiller on 5/15/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
//import Introspect

struct PopupAlert: View {
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
                   textField.becomeFirstResponder()
                }
                .textFieldStyle(FormTextFieldStyle())
            
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.showAlert = false
                    }
                }) {
                    Text("Cancel")
                }
                .saveButtonStyle(type: "Cancel")
                Spacer()
                Button(action: {print("Hallo")}) {
                    HStack {
                        Image(systemName: self.typeIcon)

                    Text(self.alertType)
                    }
                }
                .saveButtonStyle(type: self.alertType)
            }.padding(.top, 5)
        }.frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct PopupAlert_Previews: PreviewProvider {
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
                PopupAlert(creature: coreDataObject, alertType: "Heal", showAlert: .constant(true)).environment(\.managedObjectContext, context)
                
                PopupAlert(creature: coreDataObject, alertType: "Damage", showAlert: .constant(true)).environment(\.managedObjectContext, context)
                
                PopupAlert(creature: coreDataObject, alertType: "Initiative", showAlert: .constant(true)).environment(\.managedObjectContext, context)
            }.padding()
        }
    }
}

