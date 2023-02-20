
import SwiftUI

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}



func currentWindow() -> UIWindow?{
    guard let connectedScenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene> else {
        return nil
    }
    for windowScene in connectedScenes where windowScene.activationState == UIScene.ActivationState.foregroundActive {
        for windowItem in windowScene.windows where windowItem.rootViewController!.isKind(of: UINavigationController.self){
            return windowItem
        }
        return windowScene.windows.first
    }
    return nil
}


