import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack() {
            Image("MainButton")
            Text(Constants.title).font(Font.title).padding(24)
            Text(Constants.aboutText).font(Font.body).padding(12)
            Text(Constants.disclaimerText).font(Font.body).padding(12)
        }
    }
}


#Preview {
    AboutView()
}
