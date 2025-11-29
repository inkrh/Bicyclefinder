import SwiftUI

struct MappinView: View {
    let selectedPin: Station

    var body: some View {
        VStack {
            Text(selectedPin.name)
            Text("Empty Slots: \(selectedPin.emptySlots)")
            Text("Free Bikes: \(selectedPin.freeBikes)")
        }
    }
}

#Preview {
    MappinView(selectedPin: dummyCities.network.stations.first!)
}
