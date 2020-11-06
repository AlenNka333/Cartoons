import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var backgroundSessionCompletionHandler: (() -> Void)?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let serviceLocator = ServiceLocator()
        let rootCoordinator = RootAssembly.makeRootCoordinator(window: window, serviceLocator: serviceLocator)
        rootCoordinator.start()
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
          backgroundSessionCompletionHandler = completionHandler
    }
}
