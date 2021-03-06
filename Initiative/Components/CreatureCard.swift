//
//  CreatureCard.swift
//  Initiative
//
//  Created by Sam Weiller on 5/13/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import CoreData

struct CreatureCard: View {
    let creature: Creature
    
    @Binding var showAlert: Bool
    @Binding var alertContent: Creature
    @Binding var alertType: String
    @Binding var showModal: Bool
    @Binding var modalType: String
    
//    @Binding var alertContent: Dictionary<String, Any>?
    
    func activateAlertWithParameters(content: Creature, type: String) {
        withAnimation {
            self.showAlert = true
        }
        self.alertContent = content
        self.alertType = type
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 4) {
                Button(action: {
                    self.showAlert = true
                    self.alertContent = self.creature
                    self.alertType = "Initiative"
                }) {
                    ZStack {
                        Hexagon(type: creature.type ?? "")
                            .frame(width: 60, height: 70)
                        Text(creature.initiative ?? "?").multilineTextAlignment(.center).padding(2.0).cardInitValueStyle().opacity(0.87)
                    }.foregroundColor(Color(getColorFromType(type: creature.type!)))
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    self.showModal = true
                    self.modalType = "edit"
                    self.alertContent = self.creature
                }) {
                    VStack(alignment: .leading) {
                        Text(creature.name ?? "Unknown").cardNameStyle()
                        Text(creature.type ?? "Unknown").cardTypeStyle()
                    }.padding(.leading)
                }.buttonStyle(PlainButtonStyle())
                Spacer()
                Button(action: {
                    self.showAlert = true
                    self.alertContent = self.creature
                    self.alertType = "HP"
                }) {
                    HStack(spacing: 4) {
                        if (creature.maxHP != "") {
                            Text(creature.currentHP ?? "?")
                                .cardCurrentHPStyle(level: determineHPLevel(currentHP: creature.currentHP, maxHP: creature.maxHP))
                            VStack(spacing: -3) {
                                Text("HP").cardHPLabelStyle()
                                Text("/\(creature.maxHP ?? "?")").cardMaxHPStyle()
                            }
                        }
                    }
                }.buttonStyle(PlainButtonStyle())
            }
                .frame(maxWidth: .infinity)
                .padding()
                .background(creature.currentHP == "0" ? Color("CoreDisabled") : Color("Card Background"))
//                .cornerRadius(8)
                .cornerRadius(8, corners: [.topLeft, .topRight])
           
            HStack {
                Button(action: {
                    self.showAlert = true
                    self.alertContent = self.creature
                    self.alertType = "Initiative"
                }) {
                    Image(systemName: "hexagon").actionIconStyle()
                }.padding([.horizontal])
                Button(action: {
                    self.showModal = true
                    self.modalType = "edit"
                    self.alertContent = self.creature
                }) {
                    Image(systemName: "ellipsis").actionIconStyle()
                }
                Spacer()
                Button(action: {
                    self.showAlert = true
                    self.alertContent = self.creature
                    self.alertType = "Heal"
                }) {
                    Image(systemName: "bandage").actionIconStyle()
                }
                Button(action: {
                    self.showAlert = true
                    self.alertContent = self.creature
                    self.alertType = "Damage"
                }) {
                    Image(systemName: "burst").actionIconStyle()
                }.padding([.horizontal])
            }
            .buttonStyle(PlainButtonStyle())
            .padding([.vertical], 6)
            .background(Color(getColorFromType(type: creature.type!) + "-Action"))
            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
        }
    }
}

func determineHPLevel(currentHP: String?, maxHP: String?) -> String {
    // When double tries to convert "", it returns nil. Need a coalescing operator to be sure a double actually comes back.s
    let cHP = Double(currentHP!) ?? 0 // Originally Double(currentHP ?? "0") ?? 0
    let mHP = Double(maxHP!) ?? 1
    let ratio = cHP/mHP
    
    switch ratio {
    case 0.5.nextUp...1.0:
        return "healthy"
    case 0.25.nextUp...0.5:
        return "hurting"
    case 0.0...0.25:
        return "dying"
    default:
        return "healthy"
    }
}



struct CreatureCard_Previews: PreviewProvider {
    @State(initialValue: Creature()) var theCreature: Creature

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
            CreatureCard(creature: coreDataObject, showAlert: .constant(true), alertContent: .constant(coreDataObject), alertType: .constant("Initiative"), showModal: .constant(false), modalType: .constant("edit")).environment(\.managedObjectContext, context)
        }
        //        Text("Hallo")
    }
}
