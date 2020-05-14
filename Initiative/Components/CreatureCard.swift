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
    
    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                Hexagon(type: creature.type!)
                    .frame(width: 60, height: 70)
                Text(creature.initiative ?? "?").multilineTextAlignment(.center).padding(2.0).cardInitValueStyle().opacity(0.87)
            }.foregroundColor(Color(getColorFromType(type: creature.type!)))
            
            VStack(alignment: .leading) {
                Text(creature.name ?? "Unknown").cardNameStyle()
                Text(creature.type ?? "Unknown").cardTypeStyle()
            }.padding(.leading)
            Spacer()
            Text(creature.currentHP ?? "?").cardCurrentHPStyle()
            VStack(spacing: -1) {
                Text("HP").cardHPLabelStyle()
                Text("/\(creature.maxHP ?? "?")").cardMaxHPStyle()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
    .cornerRadius(8)
    }
}


struct CreatureCard_Previews: PreviewProvider {
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
            CreatureCard(creature: coreDataObject).environment(\.managedObjectContext, context)
        }
    }
}
