import UIKit

extension UIView {
    @IBInspectable var conerRaduis: CGFloat {
        get {layer.cornerRadius}
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
