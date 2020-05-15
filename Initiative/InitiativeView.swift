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
                        CreatureCard(creature: creature)
                    }
                }
                
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
