//
//  PopupAlert.swift
//  Initiative
//
//  Created by Sam Weiller on 5/15/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI
import Introspect

struct TextAlert: View {
    var alertType: String // Party/Encounter
    
    @State var value: String = ""
    @Binding var showAlert: Bool
    @Binding var navIsActive: Bool
    @Binding var createdParty: Party
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            Text("Name Your " + self.alertType + "...").cardNameStyle()
            TextField("", text: $value)
                .introspectTextField { textField in
                    textField.becomeFirstResponder()
            }
            .textFieldStyle(FormTextFieldStyle())
            
            HStack {
                Button(action: {
                    print("canceling")
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.showAlert = false
                    }
                }) {
                    Image(systemName: "xmark")
                }
                .smallButtonStyle(type: "Disabled")
                .padding(.trailing, 10.0)
                
                Spacer()
            
                Button(action: {
                    self.moc.performAndWait {
                        if (self.alertType == "Party") {
                            var cdObject: Party
                            cdObject = Party(context: self.moc)
                            cdObject.partyID = UUID()
                            cdObject.name = self.value
                            self.createdParty = cdObject
                        } else if (self.alertType == "Encounter") {
                            var cdObject: Encounter
                            cdObject = Encounter(context: self.moc)
                            cdObject.encounterID = UUID()
                            cdObject.name = self.value
                        }
                        try? self.moc.save()
                    }
                    self.navIsActive = true
                    withAnimation(.easeInOut(duration: 0.25)) {
                        self.showAlert = false
                    }
                }) {
                    HStack {
                        Image(systemName: "bandage")
                        Text("Create " + self.alertType)
                    }
                }
                .saveButtonStyle(type: "Initiative")
                
            }.padding(.top, 5)
        }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("Card Background"))
            .cornerRadius(8)
    }
}

//struct TextAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let coreDataObject = Party(context: context)
//        coreDataObject.name = "Mighty Nein"
//        return ZStack {
//            Color(.gray).edgesIgnoringSafeArea(.all)
//            VStack(spacing: 15) {
//                TextAlert(alertType: "Party", showAlert: .constant(true), navIsActive: .constant(false), createdParty: coreDataObject).environment(\.managedObjectContext, context)
//            }.padding()
//        }
//    }
//}

