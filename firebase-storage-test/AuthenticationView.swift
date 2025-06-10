import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

final class AuthenticationViewModel: ObservableObject {
    func signInGoogle() async throws {
        guard let topVC = await UIViewControllerUtil.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSingInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSingInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSingInResult.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

    }
}

struct AuthenticationView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        Spacer()
        
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .pressed)) {
            
        }
    }
}

#Preview {
    AuthenticationView()
}
