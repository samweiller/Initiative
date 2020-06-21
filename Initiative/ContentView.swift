//
//  ContentView.swift
//  Initiative
//
//  Created by Sam Weiller on 5/12/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    init() {
           // To remove only extra separators below the list:
           UITableView.appearance().tableFooterView = UIView()

           // To remove all separators including the actual ones:
           UITableView.appearance().separatorStyle = .none
           UITableView.appearance().backgroundColor = .clear // tableview background
           UITableViewCell.appearance().backgroundColor = .clear // cell background
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor(red: 0.5, green: 0.33, blue: 0.62, alpha: 1)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font : UIFont(name:"CircularStd-Bold", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name:"CircularStd-Bold", size: 34)!]
       }
    
    @State private var selection = 1
 
    var body: some View {
        TabView(selection: $selection){
            PartiesView()
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
            EncountersView()
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
