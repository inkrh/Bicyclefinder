//TODO: put this feature back in, was previously used in Xamarin.forms version for initial zoom level and distance
import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

struct UnitOfLength {
    static let kilometers = UnitOfLength(fromMilesFactor: 1.609344)
    static let nauticalMiles = UnitOfLength(fromMilesFactor: 0.8684)
    static let miles = UnitOfLength(fromMilesFactor: 1)

    private let fromMilesFactor: Double

    private init(fromMilesFactor: Double) {
        self.fromMilesFactor = fromMilesFactor
    }

    func convertFromMiles(_ input: Double) -> Double {
        return input * fromMilesFactor
    }
}

struct DistanceBetween {
    static func distanceTo(baseCoordinates: Coordinates, targetCoordinates: Coordinates, unitOfLength: UnitOfLength) -> Double {
        let baseRad = Double.pi * baseCoordinates.latitude / 180
        let targetRad = Double.pi * targetCoordinates.latitude / 180
        let theta = baseCoordinates.longitude - targetCoordinates.longitude
        let thetaRad = Double.pi * theta / 180

        var dist = sin(baseRad) * sin(targetRad) + cos(baseRad) * cos(targetRad) * cos(thetaRad)
        dist = acos(dist)

        dist = dist * 180 / Double.pi
        dist = dist * 60 * 1.1515

        return unitOfLength.convertFromMiles(dist)
    }
}
