//
//  NewsListScreen.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 14/06/25.
//

import Foundation
import SwiftUI

struct NewsListScreen: View {
    
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        router.pop()
                    } label: {
                        Image(systemName: "chevron.backward")
                        Text("News List")
                    }
                }
            }
    }
}

#Preview {
    NewsListScreen()
}
