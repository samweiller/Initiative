//
//  AddPartyView.swift
//  Initiative
//
//  Created by Sam Weiller on 6/19/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import Combine
import Introspect

struct EditPartyView: View {
    @Binding var showModal: Bool
    var party: Party
    
    
//    @FetchRequest(
//        entity: Creature.entity(),
//        sortDescriptors: [],
//        predicate:
//    ) var partyCreatures: FetchedResults<Creature>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        // Converts creatures to a Set bc Swift can't ForEach a linked entity
        let partyCreatures: [Creature] = {
            if let creatures = party.creatures as? Set<Creature> {
            return Array(creatures)
          }
          return [Creature]()
        }()
        
        return ZStack {
            VStack(alignment: .leading, spacing: 0) {
//                HStack {
//                    
//                }
                HStack {
                    Text(party.name ?? "Unknown")
                    .smallerTitleStyle()
                    Spacer()
                    Button(action: {
//                        self.showModal.toggle()
//                        self.modalType = "new"
                    }) {
                        Image(systemName: "ellipsis")
                            .padding(.trailing)
                            .foregroundColor(Color("CorePurple"))
                            .font(.title)
                    }
                }
                Text("Members").formLabelStyle().padding([.horizontal])
                Spacer()
                List {
                    ForEach(partyCreatures, id: \.creatureID) { creature in
                        Text("Unknown")
                    }
                }
            }
        }
        .background(Color("MainBackground").edgesIgnoringSafeArea(.all))
    }
}

//struct EditPartyView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPartyView(showModal: .constant(true), party: Party())
//    }
//}
