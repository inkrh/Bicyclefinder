//
//  Constants.swift
//  BikeFinder
//
//  Created by Robert Smith on 11/26/25.
//


import Foundation

enum Constants {
    //old API URL pulled hard JSON
//    static let networkURL = "https://api.citybik.es/networks.json"
    //new API uses a base URL and has way more info than we need, so filtering data
    static let BASEURL = "https://api.citybik.es"
    static let networkURL = BASEURL+"/v2/networks?fields=id,name,href,location"
    //create Apple maps directions leveraging Apple's maps API
    static var appleMapsURL = "https://maps.apple.com/?daddr=%@,%@"
    //TODO: tidy up below constants, most of the below is from previous versions and no longer used
    static let cityBikesURL = "https://citybik.es"
    static let mainIcon = "Icon-60.png"
    static let mainButton = "MainButton.png"
    static let refreshButton = "Refresh.png"
    static let poi = "POI.png"
    static let aboutButton = "About.png"
    static let routeButton = "Route.png"
    static let route = "route"
    static let menu = "menu"
    static let refresh = "refresh"
    static let tryingLocation = "trying location"
    static let cities = "cities"
    static let about = "about"
    static let locationFailed = "location failed"
    static let tryingNetworks = "Fetching bike networks"
    static let found = "found "
    static let citiesSpace = " cities"
    static let location = "location "
    static let connectionLost = "Data connection lost"
    static let error = "Error"
    static let ok = "Ok"
    static let pinAvailable = "Available : "
    static let available = " available\n"
    static let free = " free slots\n"
    static let bikeStation = "Bike Station Details"
    static let title = "BicycleFinder"
    static let aboutText = "BicycleFinder provides information on public bike stations around the world."
    static let disclaimerText = """
    BicycleFinder is an independently created demo app which uses information from the citybik.es api. Although every effort has been made to ensure reliability, bike station details and the number of available bikes cannot be guaranteed.
    """
}
