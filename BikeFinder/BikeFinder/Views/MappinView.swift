import SwiftUI

struct MappinView: View {
    let selectedPin: Station
    let cityName: String
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack {
            Image("MainButton")
            
            Text("\(cityName) \(Constants.bikeStation)").font(Font.title).padding(24)
            Text("Station: \(selectedPin.name)").font(Font.body).padding(12)
            Text("Need to park a bike?").font(Font.title2)
            Text("Empty Slots: \(selectedPin.emptySlots)").font(Font.body).padding(12)
            Text("Need to rent a bike?").font(Font.title2)
            Text("Free Bikes: \(selectedPin.freeBikes)").font(Font.body).padding(12)
        }
        HStack {
            Button {
                let lat = String(selectedPin.latitude)
                let lon = String(selectedPin.longitude)
                if let url = URL(string: String(format: Constants.appleMapsURL, lat, lon)) {
                    openURL(url)
                }
            } label: {
                Image("RouteButton").resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit).accessibilityHint("Opens Apple Maps with directions to station")
                Text("Directions")
            }
        }
    }
}

#Preview {
    MappinView(selectedPin: dummyCities.network.stations.first!, cityName: dummyNetworks.networks.first!.location.city)
}
