import Foundation
struct NetworksModel: Codable {
    let networks: [NetworkModel]
}

struct NetworkModel: Codable {
    let id, name, href: String
    let location: Location
}

struct Location: Codable {
    let latitude, longitude: Double
    let city, country: String
}

var dummyNetworks: NetworksModel = NetworksModel(networks: [NetworkModel(id: "0", name: "Loading", href: "NONE", location:         Location(latitude: 0, longitude: 0, city: "Loading", country: "TEST"))])


