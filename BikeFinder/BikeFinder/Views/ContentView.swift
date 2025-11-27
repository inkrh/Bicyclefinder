//
//  ContentView.swift
//  BikeFinder
//
//  Created by Robert Smith on 11/26/25.
//

import SwiftUI
import MapKit
import SwiftyJSON

struct ContentView: View {
    @State var networkData: NetworksModel?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(networkData?.networks ?? dummyNetworks.networks, id: \.id) { result in
                    NavigationLink(destination: MapDisplayView(selectedNetwork: result)) {
                        Text(result.location.city)
                    }
                }
            }
            .task {
                // Fetch the network data on view load
                let controller = NetworksController()
                networkData = await controller.makeRequest()
                
            }
        }
    }
}

#Preview {
    ContentView()
}
