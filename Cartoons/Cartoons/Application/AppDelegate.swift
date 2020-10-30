import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let serviceLocator = ServiceLocator()
        let rootCoordinator = RootAssembly.makeRootCoordinator(window: window, locator: serviceLocator)
        rootCoordinator.start()
        return true
    }
}