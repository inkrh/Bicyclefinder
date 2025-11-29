import SwiftUI
import MapKit
import SwiftyJSON

struct MapDisplayView: View {
    let selectedNetwork: NetworkModel
    @State var cityData: CitiesModel?

    @State private var region: MKCoordinateRegion

    init(selectedNetwork: NetworkModel) {
        self.selectedNetwork = selectedNetwork
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: CLLocationDegrees(selectedNetwork.location.latitude), longitude: CLLocationDegrees(selectedNetwork.location.longitude)),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ))
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: cityData?.network.stations ?? []) { location in
                MapAnnotation(
                   coordinate: location.coordinate,
                   content: {
                       NavigationLink(destination: MappinView(selectedPin:location)) {
                           Image("MapPin").accessibilityHint(Text("Tap to view bike station at \(location.name) details."))
                       }
                      
                   }
                )
            }
            .ignoresSafeArea().task {
                // Fetch the network data on view load
                let controller = CityController()
                cityData = await controller.makeRequest(cityUrl: selectedNetwork.href)
            }
            HStack {
                NavigationLink(destination: AboutView()) {
                    Image("HelpButton")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)                }
                .accessibility(label: Text("About this app."))
            }
        }
    }
}

extension Station {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

#Preview {
    MapDisplayView(selectedNetwork: dummyNetworks.networks.first!)
}
