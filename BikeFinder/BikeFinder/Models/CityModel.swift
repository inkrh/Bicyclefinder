import Foundation

struct CitiesModel: Codable {
    let network: CityModel
}

struct CityModel: Codable {
    let stations: [Station]
}

struct Station: Codable, Identifiable { // <- Added Identifiable here
    let id, name: String
    let latitude, longitude: Double
    let timestamp: String
    let freeBikes, emptySlots: Int

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, timestamp
        case freeBikes = "free_bikes"
        case emptySlots = "empty_slots"
    }
}

var dummyCities: CitiesModel = (
    CitiesModel(network: CityModel(stations: [Station(id: "0", name: "TEST", latitude: 0, longitude: 0, timestamp: "", freeBikes: 0, emptySlots: 0)])))
