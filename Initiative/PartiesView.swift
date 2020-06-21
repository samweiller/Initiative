//
//  PartiesView.swift
//  Initiative
//
//  Created by Sam Weiller on 6/19/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI

struct PartiesView: View {
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    
    @FetchRequest(
        entity: Party.entity(),
        sortDescriptors: []
    ) var parties: FetchedResults<Party>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showAlert = false // not needed for parties
    @State private var navIsActive = false
    @State private var modalType = "" // not needed for parties
    @State var newPartyObject: Party = Party()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Parties").multilineTextAlignment(.leading).viewTitleStyle()
                        Spacer()
                        Button(action: {
                            self.showAlert.toggle()
                            self.modalType = "new"
                        }) {
                            Image(systemName: "plus")
                                .padding(.trailing)
                                .foregroundColor(Color("CorePurple"))
                                .font(.title)
                        }
                        
                        // Navigate to NEW party editor
                        NavigationLink(destination: EditPartyView(party: self.newPartyObject), isActive: self.$navIsActive,
                        label: { EmptyView() })
                    }.background(Color("MainBackground"))
                    
                    List {
                        ForEach(parties, id: \.partyID) { party in
                            PartyCard(party: party)
                        }
                    }
                    
                    Spacer()
                }
                if self.showAlert {
                    ZStack {
                        Color("Alert Overlay")
                        TextAlert(alertType: "Party", showAlert: self.$showAlert, navIsActive: self.$navIsActive, createdParty: self.$newPartyObject)
                        .padding()
                    }.edgesIgnoringSafeArea(.all)
                }
            }.background(Color("MainBackground").edgesIgnoringSafeArea(.all))
            .navigationBarTitle("")
            .navigationBarHidden(true)
                .onAppear{
                    self.navIsActive = false
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PartiesView_Previews: PreviewProvider {
    static var previews: some View {
        PartiesView()
    }
}
