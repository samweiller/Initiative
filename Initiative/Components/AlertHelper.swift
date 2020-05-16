//
//  AlertHelper.swift
//  Initiative
//
//  Created by Sam Weiller on 5/15/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import SwiftUI

struct CustomAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(self.isShowing)
                VStack {
                    Text(self.title)
                    TextField("", text: self.$text)
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                        }) {
                            Text("Dismiss")
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

}

//struct AlertHelper_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlert()
//    }
//}

extension View {
    func customAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String) -> some View {
        CustomAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       title: title)
    }

}
