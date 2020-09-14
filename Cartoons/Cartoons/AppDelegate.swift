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
        if !AppData.isFirstComing {
            router.initOnBoarding()
             window?.rootViewController = router.onBoarding
        } else {
            router.initialViewController()
            window?.rootViewController = router.navigationController
        }
        window?.makeKeyAndVisible()
        return true
    }
}
