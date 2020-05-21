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

    }
    
    @FetchRequest(
        entity: Creature.entity(),
        sortDescriptors: []
    ) var creatures: FetchedResults<Creature>
    @Environment(\.managedObjectContext) var moc
    
    @State private var showModal = false
    @State private var modalType = "" // new/edit
    @State private var showAlert = false
    @State private var alertContent: Creature = Creature()
    @State private var alertType = ""
    @State private var sortBy = "Initiative"
        
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Initiative").multilineTextAlignment(.leading).viewTitleStyle()
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                        self.modalType = "new"
                    }) {
                        Image(systemName: "plus")
                            .padding(.trailing)
                        .foregroundColor(Color("CorePurple"))
                            .font(.title)
                    }.sheet(isPresented: $showModal) {
                        AddCreatureView(modalType: self.modalType, showModal: self.$showModal, creature: self.modalType == "new" ? nil : self.alertContent)
                            .environment(\.managedObjectContext, self.moc)
                    }
                }.background(Color("MainBackground"))
                List {
                    ForEach(creatures.sorted(by: {
                        if self.sortBy == "Initiative" {
                            return $0.initiative!.localizedStandardCompare($1.initiative!) == .orderedDescending
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
                    Color("CoreDisabled")
                    PopupAlert(creature: self.alertContent, alertType: self.alertType, showAlert: self.$showAlert)
                    .padding()
                }.edgesIgnoringSafeArea(.all)
            } else {
                 EmptyView()
            }
        }.background(Color("MainBackground").edgesIgnoringSafeArea(.all))
    }
}

struct ListItem {
    
}

struct InitiativeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return InitiativeView().environment(\.managedObjectContext, context)
        
    }
}
