//
//  ContentView.swift
//  API-SuperHero
//
//  Created by Eichan Nakagawa on 01/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink   (destination:SuperHeroSearcher()){
                    Text("SuperHero Searcher")
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
