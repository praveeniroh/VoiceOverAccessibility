//
//  AdvancedTopics.swift
//  VoiceOverAccessibility
//
//  Created by praveen-12298 on 23/03/25.
//

enum AdvancedTopics:CaseIterable{
    case changingDefaultOrder
    case customActions
    case customRotors
    case activationPoint
    case moreContent

    var title: String {
        switch self {
        case .changingDefaultOrder:
            return "Chaging Default Focus Order"
        case .customActions:
            return "Custom Actions"
        case .customRotors:
            return "Custom Rotors"
        case .activationPoint:
            return "Activation Point"
        case .moreContent:
            return "Adding More Content"
        }
    }
}
