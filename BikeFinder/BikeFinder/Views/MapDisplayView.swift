import SwiftUI
import MapKit
import SwiftyJSON

//TODO: pin clustering

struct MapDisplayView: View {
    let selectedNetwork: NetworkModel
    @State var cityData: CitiesModel?

    @State private var region: MKCoordinateRegion
    @State private var cameraPosition: MapCameraPosition // For iOS 17+

    init(selectedNetwork: NetworkModel) {
        self.selectedNetwork = selectedNetwork
        let initialRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: CLLocationDegrees(selectedNetwork.location.latitude),
                longitude: CLLocationDegrees(selectedNetwork.location.longitude)
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        _region = State(initialValue: initialRegion)
        if #available(iOS 17.0, *) {
            _cameraPosition = State(initialValue: .region(initialRegion))
        } else {
            _cameraPosition = State(initialValue: .automatic) // Unused on iOS 16-
        }
    }
    
    var body: some View {
        VStack {
            if #available(iOS 17.0, *) {
                if let stations = cityData?.network.stations {
                    if stations.isEmpty {
                        Text("No stations found.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding()
                        Spacer()
                    } else {
                        Map(position: $cameraPosition) {
                            ForEach(stations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    NavigationLink(destination: MappinView(selectedPin: location, cityName: selectedNetwork.location.city)) {
                                        Image("MapPin")
                                            .accessibilityHint(Text("Tap to view bike station at \(location.name) details."))
                                    }
                                }
                            }
                        }
                        .ignoresSafeArea()
                    }
                } else {
                    ProgressView("Loading stations…")
                        .padding()
                    Spacer()
                }
            } else {
                // Fallback for iOS 16 and earlier
                if let stations = cityData?.network.stations {
                    if stations.isEmpty {
                        Text("No stations found.")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding()
                        Spacer()
                    } else {
                        Map(coordinateRegion: $region, annotationItems: stations) { location in
                            MapAnnotation(
                                coordinate: location.coordinate,
                                content: {
                                    NavigationLink(destination: MappinView(selectedPin: location, cityName: selectedNetwork.location.city)) {
                                        Image("MapPin")
                                            .accessibilityHint(Text("Tap to view bike station at \(location.name) details."))
                                    }
                                }
                            )
                        }
                        .ignoresSafeArea()
                    }
                } else {
                    ProgressView("Loading stations…")
                        .padding()
                    Spacer()
                }
            }
            HStack {
                NavigationLink(destination: AboutView()) {
                    Image("HelpButton")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                .accessibility(label: Text("About this app."))
            }
        }
        .task {
            // Fetch the network data on view load (only runs once due to .task's placement)
            if cityData == nil {
                let controller = CityController()
                cityData = await controller.makeRequest(cityUrl: selectedNetwork.href)
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
