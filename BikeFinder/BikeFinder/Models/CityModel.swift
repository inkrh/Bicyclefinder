import Foundation

// throwing away a lot of structured data here, but the data quality varies by network, sticking to just what is known as should be there
struct CitiesModel: Codable {
    let network: CityModel
}

struct CityModel: Codable {
    let stations: [Station]
}

struct Station: Codable, Identifiable {
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
