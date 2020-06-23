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
    
    var inputParty: Party? = nil
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var party = Party()
    @State private var showModal = false
    @State private var modalType = "new" // new/edit
    @State private var alertAge = "new" // new/edit
    @State private var showNameAlert = false
    
    // For CreatureCard
    @State private var showAlert = false
    @State private var alertContent: Creature = Creature()
    @State private var alertType = ""
    
    var btnBack : some View {
        Button(action: {
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
    
    var btnAdd : some View {
        Button(action: {
            self.showModal.toggle()
            self.modalType = "new"
        }) {
            HStack {
                Image(systemName: "pencil")
                .padding(.trailing)
                .foregroundColor(Color("CorePurple"))
                .font(.title)
            }.sheet(isPresented: $showModal) {
                AddCreatureView(modalType: self.modalType, sender: "party", showModal: self.$showModal, party: self.party)
                    .environment(\.managedObjectContext, self.moc)
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
                    Text(party.name ?? "")
                        .viewTitleStyle()
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                        self.modalType = "new"
                    }) {
                        Image(systemName: "pencil")
                            .padding(.trailing)
                            .foregroundColor(Color("CorePurple"))
                            .font(.title)
                    }
                }
//                Text("Members").formLabelStyle().padding([.horizontal])
//                Spacer()
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
            if self.showAlert {
                ZStack {
                    Color("Alert Overlay")
                    TextAlert(alertType: "Party", alertAge: self.alertAge, showAlert: self.$showNameAlert, createdParty: self.$party)
                    .padding()
                }.edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack, trailing: btnAdd)
        .background(Color("MainBackground").edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .onAppear{
            if self.inputParty != nil {
                self.party = self.inputParty!
            }
            
        }
        
    }
}

//struct EditPartyView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPartyView(showModal: .constant(true), party: Party())
//    }
//}
