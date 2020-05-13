//
//  InitiativeView.swift
//  Initiative
//
//  Created by Sam Weiller on 5/12/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import CoreData

struct InitiativeView: View {
    @FetchRequest(entity: Creature.entity(), sortDescriptors: []) var creatures: FetchedResults<Creature>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        VStack {
            List {
                ForEach(creatures, id: \.name) { creature in
                    Text(creature.name ?? "Unknown")
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let creature = Creature(context: self.moc)
                creature.type = "Party"
                creature.name = "\(chosenFirstName) \(chosenLastName)"
                try? self.moc.save()

            }
        }
    }
}

struct InitiativeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return InitiativeView().environment(\.managedObjectContext, context)

    }
}
