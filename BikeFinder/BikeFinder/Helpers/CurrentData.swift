//
//  CurrentData.swift
//  BikeFinder
//
//  Created by Robert Smith on 11/26/25.
//

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

