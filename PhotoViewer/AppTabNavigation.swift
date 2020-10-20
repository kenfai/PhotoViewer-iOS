//
//  AppTabNavigation.swift
//  PhotoViewer
//
//  Created by Ginger on 20/10/2020.
//

import SwiftUI

struct AppTabNavigation: View {
    @State private var selection: Tab = .list
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                ContentView()
            }
            .tabItem {
                Label("List", systemImage: "list.bullet")
                    .accessibility(label: Text("List Layout"))
            }
            
            NavigationView {
                ImageGridView()
            }
            .tabItem
            {
                Label("Grid", systemImage: "rectangle.3.offgrid")
                    .accessibility(label: Text("Grid Layout"))
            }
        }
    }
}

extension AppTabNavigation {
    enum Tab {
        case list
        case grid
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
