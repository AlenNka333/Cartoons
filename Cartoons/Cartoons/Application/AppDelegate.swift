import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let locator = ServiceLocator()
        locator.register(AuthorizationService())
        locator.register(StorageDataService())
        locator.register(UserDataService())
        let rootCoordinator = RootAssembly.makeRootCoordinator(window: window, locator: locator)
        rootCoordinator.start()
        return true
    }
}
