import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack() {
            Image("MainButton")
            Text(Constants.title).font(Font.title).padding(36)
            Text(Constants.aboutText).font(Font.body).padding(24)
            Text(Constants.disclaimerText).font(Font.body).padding(24)
        }
    }
}


#Preview {
    AboutView()
}
