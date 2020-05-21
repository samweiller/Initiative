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
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background

    }
    
    @FetchRequest(entity: Creature.entity(), sortDescriptors: []) var creatures: FetchedResults<Creature>
    @Environment(\.managedObjectContext) var moc
    
    @State private var showModal = false
    @State private var showAlert = false
    @State private var alertContent: Creature = Creature()
    @State private var alertType = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Initiative").multilineTextAlignment(.leading).viewTitleStyle()
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Image(systemName: "plus")
                            .padding(.trailing)
                        .foregroundColor(Color("CorePurple"))
                            .font(.title)
                    }.sheet(isPresented: $showModal) {
                        AddCreatureView(showModal: self.$showModal)
                            .environment(\.managedObjectContext, self.moc)
                    }
                }.background(Color("MainBackground"))
                List {
                    ForEach(creatures, id: \.name) { creature in
                        CreatureCard(creature: creature, showAlert: self.$showAlert, alertContent: self.$alertContent, alertType: self.$alertType)
//                        HStack(spacing: 4) {
//                            ZStack {
//                                Hexagon(type: creature.type!)
//                                    .frame(width: 60, height: 70)
//                                Text(creature.initiative ?? "?").multilineTextAlignment(.center).padding(2.0).cardInitValueStyle().opacity(0.87)
//                            }.foregroundColor(Color(getColorFromType(type: creature.type!)))
//
//                            VStack(alignment: .leading) {
//                                Text(creature.name ?? "Unknown").cardNameStyle()
//                                Text(creature.type ?? "Unknown").cardTypeStyle()
//                            }.padding(.leading)
////                            Spacer()
//                            Button(action: {
//                                withAnimation(.easeInOut(duration: 0.25)) {
//                                    self.showAlert = true
//                                    self.alertContent = creature
//                                }
//                            }) {
//                            Text("Show Alert")
//                            }
//                            Text(creature.currentHP ?? "?").cardCurrentHPStyle()
//                            VStack(spacing: -1) {
//                                Text("HP").cardHPLabelStyle()
//                                Text("/\(creature.maxHP ?? "?")").cardMaxHPStyle()
//                            }
//                        }
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(8, corners: [.topLeft, .topRight])
                    }
                }
                
            }
            if self.showAlert {
                ZStack {
                    Color("CoreDisabled")
                    PopupAlert(creature: self.alertContent, alertType: self.alertType, showAlert: self.$showAlert)
                }
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
