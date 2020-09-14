import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
  
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let wnd = window else {
            return false
        }
        let router = Router(window: wnd)
        switch CheckApplicationStateHelper.checkState() {
        case .firstTime:
            router.showOnBoarding()
            wnd.rootViewController = router.onBoarding
        case .authorized:
            router.showTabBarController()
            wnd.rootViewController = router.tabBarController
        case .notAuthorized:
            router.showAuthorizationController()
            wnd.rootViewController = router.navigationController
        }
        wnd.makeKeyAndVisible()
        return true
    }
}
