//
//  NavigationRouter.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/06/25.
//

import Foundation

@Observable
final class NavigationRouter {
    
    var routes: [Route] = []
    
    func push(to screen: Route) {
        routes.append(screen)
    }
    
    func pop() {
        guard !routes.isEmpty else { return }
        routes.removeLast()
    }
    
    func pop(to screen: Route) {
        guard !routes.isEmpty else { return }
        while (routes.last != screen) {
            _ = routes.popLast()
        }
    }
    
    func reset() {
        routes.removeAll()
    }
}
