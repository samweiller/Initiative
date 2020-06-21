//
//  PartiesView.swift
//  Initiative
//
//  Created by Sam Weiller on 6/19/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import CoreData
import Foundation

struct EncountersView: View {
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    
    @FetchRequest(
        entity: Encounter.entity(),
        sortDescriptors: []
    ) var encounters: FetchedResults<Encounter>
    @Environment(\.managedObjectContext) var moc
    
    @State private var showModal = false
    @State private var modalType = "" // new/edit

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Encounters").multilineTextAlignment(.leading).viewTitleStyle()
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                        self.modalType = "new"
                    }) {
                        Image(systemName: "plus")
                            .padding(.trailing)
                            .foregroundColor(Color("CorePurple"))
                            .font(.title)
                    }
                }.background(Color("MainBackground"))}
        }.background(Color("MainBackground").edgesIgnoringSafeArea(.all))
    }
}

struct EncountersView_Previews: PreviewProvider {
    static var previews: some View {
        EncountersView()
    }
}
