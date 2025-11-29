//TODO: legacy code below was used for local handling put that back in at some point in my (or other people's) future
import Foundation

struct CurrentData
{
    let CurrentNetwork: NetworkModel;
    let CurrentCity: CityModel;
    let CurrentPosition: Position;
}

struct Position {
    let lat: Double;
    let ln: Double;
}
//
//struct City {
//    let bikes: Int;
//    let name: String;
//    let idx: Int;
//    let lat: Int;
//    let timestamp: Date;
//    let lng: Int;
//    let id: Int;
//    let free: Int;
//    let number: String;
//    let Distance: Double;
//}
//
//struct Cities {
//    let CityData: [City];
//    let CurrentCity: City;
//}

