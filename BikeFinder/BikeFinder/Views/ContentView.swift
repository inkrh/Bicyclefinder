import SwiftUI
import MapKit
import SwiftyJSON

struct ContentView: View {
    @State var networkData: NetworksModel?
    @State private var searchText = ""
    @State private var isLoading = true
    @State private var hasError = false

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
            Group {
                if isLoading {
                    VStack {
                        ProgressView("Loading networks…")
                        Text("Please wait while we fetch bike locations.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                } else if hasError {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text("Failed to load data.")
                            .font(.title2)
                            .padding(.bottom, 4)
                        Text("Please check your connection and try again.")
                            .font(.body)
                            .foregroundColor(.gray)
                        Button("Retry") {
                            Task { await reload() }
                        }
                        .padding(.top, 8)
                    }
                } else {
                    List {
                        ForEach(filteredNetworks, id: \.id) { result in
                            NavigationLink(destination: MapDisplayView(selectedNetwork: result)) {
                                Text(result.location.city).accessibilityHint(Text("Tap to view rental bikes in \(result.location.city) on map"))
                                Text(result.location.country).font(Font.footnote.italic())
                            }
                        }
                    }
                }
            }
            .task {
                await reload()
            }
            .searchable(text: $searchText, prompt: "Filter by city")
            .accessibilityHint(Text("Filters list of networks by city name"))
        }
    }

    @MainActor
    func reload() async {
        isLoading = true
        hasError = false
        let controller = NetworksController()
        let result = await controller.makeRequest()
        // Detect error if we get dummyNetworks back and the request was not for preview
        if result.networks == dummyNetworks.networks {
            hasError = true
        } else {
            networkData = result
        }
        isLoading = false
    }
}

#Preview {
    ContentView()
}
