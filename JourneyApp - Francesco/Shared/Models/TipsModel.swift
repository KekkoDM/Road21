//
//  TipsModel.swift
//  JourneyApp
//
//  Created by Ivan Esposito on 18/11/21.
//

import Foundation

@available(iOS 15, *)
struct TipsModel: Hashable {
    var id = UUID()
    var title: String
    var description: String
    var displayTime: DateComponents?
}
