//
//  EditPartyView.swift
//  Initiative
//
//  Created by Sam Weiller on 6/19/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import Combine
import Introspect

struct EditPartyView: View {
//    init() {
//        UINavigationBar.appearance().backgroundColor = .yellow
//    }
    
    var party: Party
    
    
//    @FetchRequest(
//        entity: Creature.entity(),
//        sortDescriptors: [],
//        predicate:
//    ) var partyCreatures: FetchedResults<Creature>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showModal = false
    @State private var modalType = "new" // new/edit
        
    // For CreatureCard
    @State private var showAlert = false
    @State private var alertContent: Creature = Creature()
    @State private var alertType = ""
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("CorePurple"))
                Text("Parties").navBarStyle()
            }
        }
    }


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
                    .viewTitleStyle()
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                        self.modalType = "new"
                    }) {
                        Image(systemName: "ellipsis")
                            .padding(.trailing)
                            .foregroundColor(Color("CorePurple"))
                            .font(.title)
                    }.sheet(isPresented: $showModal) {
                        AddCreatureView(modalType: self.modalType, sender: "party", showModal: self.$showModal, party: self.party)
                            .environment(\.managedObjectContext, self.moc)
                    }
                }
                Text("Members").formLabelStyle().padding([.horizontal])
                Spacer()
                List {
                    ForEach(partyCreatures, id: \.creatureID) { creature in
                        CreatureCard(
                            creature: creature,
                            showAlert: self.$showAlert,
                            alertContent: self.$alertContent,
                            alertType: self.$alertType,
                            showModal: self.$showModal,
                            modalType: .constant("edit")
                        )
                    }
                }
            }
        }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
        .background(Color("MainBackground").edgesIgnoringSafeArea(.all))
        
//        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle(Text(""), displayMode: .inline)

    }
}

//struct EditPartyView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPartyView(showModal: .constant(true), party: Party())
//    }
//}
