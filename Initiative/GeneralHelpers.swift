//
//  GeneralHelpers.swift
//  Initiative
//
//  Created by Sam Weiller on 5/13/20.
//  Copyright © 2020 saweiller. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

func getColorFromType(type: String) -> String {
    switch type {
    case "Party", "Initiative":
        return "CorePurple"
    case "Enemy":
        return "CoreCoral"
    case "Ally":
        return "CoreTeal"
    case "Heal":
        return "HealGreen"
    case "Damage":
        return "DamageRed"
    case "Disabled":
        return "CoreDisabled"
    case "Cancel":
        return "Clear"
    default:
        return "Text Primary"
    }
}

func addNumbers(first: String, second: String) -> String {
    return String(Int16(first)! + Int16(second)!)
}

func subtractNumbers(first: String, second: String) -> String {
    return String(Int16(first)! - Int16(second)!)
}
