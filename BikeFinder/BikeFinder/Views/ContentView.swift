import SwiftUI
import MapKit
import SwiftyJSON

struct ContentView: View {
    @State var networkData: NetworksModel?
    @State private var searchText = ""

    var filteredNetworks: [NetworkModel] {
        let networks = networkData?.networks ?? dummyNetworks.networks
            if searchText.isEmpty {
                return networks
            } else {
                return networks.filter {
                    $0.location.city.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredNetworks, id: \.id) { result in
                    NavigationLink(destination: MapDisplayView(selectedNetwork: result)) {
                        Text(result.location.city).accessibilityHint(Text("Tap to view rental bikes in \(result.location.city) on map"))
                        Text(result.location.country).font(Font.footnote.italic())
                    }
                }
            }
            .task {
                // Fetch the network data on view load
                let controller = NetworksController()
                networkData = await controller.makeRequest()
            }
            .searchable(text: $searchText, prompt: "Filter by city")
        }
    }
}

#Preview {
    ContentView()
}
