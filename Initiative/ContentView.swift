//
//  ContentView.swift
//  Initiative
//
//  Created by Sam Weiller on 5/12/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
 
    var body: some View {
        TabView(selection: $selection){
            Text("Second View")
            .tabItem {
                VStack {
                    Image(systemName: "person.3.fill")
                    Text("Parties")
                    .tracking(-0.25)
                    .tabViewLabelStyle()
                }
            }
            .tag(0)
            InitiativeView()
                .tabItem {
                    VStack {
                        Image(systemName: "hexagon.fill")
                        Text("Initiative")
                            .tracking(-0.25)
                            .tabViewLabelStyle()
                            
                    }
                }
                .tag(1)
            AddCreatureView()
                .tabItem {
                    VStack {
                        Image(systemName: "shield.fill")
                        Text("Encounters")
                        .tracking(-0.25)
                        .tabViewLabelStyle()
                    }
                }
                .tag(2)
        }
//        .tabViewLabelStyle()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
#endif
