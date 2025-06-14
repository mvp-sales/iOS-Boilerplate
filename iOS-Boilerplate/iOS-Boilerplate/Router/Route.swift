//
//  Route.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/06/25.
//

import Foundation
import SwiftUI

enum Route: /*View,*/ Hashable {
    case newsSourcesList
    case newsListScreen
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    /*var body: some View {
        switch self {
        case .newsSearch:
            NewsSearchView()
        case .newsSourcesList:
            NewsSourcesListView()
        }
    }*/
}

