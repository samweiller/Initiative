//
//  PartyCard.swift
//  Initiative
//
//  Created by Sam Weiller on 6/19/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import CoreData

struct PartyCard: View {
    let party: Party
    
    var body: some View {
        Button(action: {
            
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(party.name ?? "Unknown").cardNameStyle()
                    Text(String(party.creatures!.count) + " members").cardTypeStyle()
                }
                
                Spacer()
                Image(systemName: "chevron.right")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding([.vertical], 10)
            .background(Color("Card Background"))
            .cornerRadius(8)
        }
    }
}

struct PartyCard_Previews: PreviewProvider {
    @State(initialValue: Party()) var theParty: Party
    
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let coreDataObject = Party(context: context)
        coreDataObject.name = "The Mighty Nein"
        return ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            PartyCard(party: coreDataObject).environment(\.managedObjectContext, context)
        }
    }
}
