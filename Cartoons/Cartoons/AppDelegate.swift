import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootCoordinator = RootAssembly.makeRootCoordinator(window: window)
        rootCoordinator.start()
//        let router = Router(window: window)
//        router.start()
        return true
    }
}
