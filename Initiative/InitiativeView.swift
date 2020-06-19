//
//  InitiativeView.swift
//  Initiative
//
//  Created by Sam Weiller on 5/12/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import CoreData
import Foundation

struct InitiativeView: View {
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
        
//        self.sortedCreatures = sortByInitiative(creatures: self.creatures)
    }
    
    @FetchRequest(
        entity: Creature.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isLive == %@", true)
    ) var creatures: FetchedResults<Creature>
    @Environment(\.managedObjectContext) var moc
    
    @State private var showModal = false
    @State private var modalType = "" // new/edit
    @State private var showAlert = false
    @State private var alertContent: Creature = Creature()
    @State private var alertType = ""
    @State private var sortBy = "Initiative"
//    @State private var sortedCreatures: FetchedResults<Creature>
    
    @State private var showingActionSheet = false
        
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Initiative").multilineTextAlignment(.leading).viewTitleStyle()
                    Spacer()
                    Button(action: {
                        self.showingActionSheet.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease")
                        .padding(.trailing)
                        .foregroundColor(Color("CorePurple"))
                        .font(.title)
                    }
                    Button(action: {
                        self.showModal.toggle()
                        self.modalType = "new"
                    }) {
                        Image(systemName: "plus")
                            .padding(.trailing)
                            .foregroundColor(Color("CorePurple"))
                            .font(.title)
                    }.sheet(isPresented: $showModal) {
                        AddCreatureView(modalType: self.modalType, sender: "initiative", showModal: self.$showModal, creature: self.modalType == "new" ? nil : self.alertContent)
                            .environment(\.managedObjectContext, self.moc)
                    }
                }.background(Color("MainBackground"))
                                
                List {
                    ForEach(creatures.sorted(by: {
                        if self.sortBy == "Initiative" {
                            return $0.initiative!.localizedStandardCompare($1.initiative!) == .orderedDescending
                        } else if self.sortBy == "Name" {
                            return $0.name! < $1.name!
                        } else if self.sortBy == "Type" {
                            return $0.type! < $1.type!
                        } else {
                            return true
                        }
                    }), id: \.creatureID) { creature in
                        CreatureCard(creature: creature, showAlert: self.$showAlert, alertContent: self.$alertContent, alertType: self.$alertType, showModal: self.$showModal, modalType: self.$modalType)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            self.moc.delete(self.creatures[index])
                        }
                    }
                }
                
            }
            if self.showAlert {
                ZStack {
                    Color("Alert Overlay")
                    PopupAlert(creature: self.alertContent, alertType: self.alertType, showAlert: self.$showAlert)
                    .padding()
                }.edgesIgnoringSafeArea(.all)
            }
        }.background(Color("MainBackground").edgesIgnoringSafeArea(.all))
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Sort Creatures"), buttons: [
                .default(Text("Initiative")) {
                    self.sortBy = "Initiative"
                },
                .default(Text("Name")) { self.sortBy = "Name" },
                .default(Text("Creature Type")) { self.sortBy = "Type" },
                .cancel()
            ])
        }
    }
}

//func sortByInitiative(creatures: Array<Creature>) -> Array<Creature> {
//    creatures.sorted(by: {
//        return $0.initiative!.localizedStandardCompare($1.initiative!) == .orderedDescending
//    })
//}

struct InitiativeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return InitiativeView().environment(\.managedObjectContext, context)
        
    }
}
