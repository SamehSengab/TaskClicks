import UIKit
import NVActivityIndicatorView

extension UIViewController {
    func lock(frameRect: CGRect = CGRect.zero) {
        let activityIndicatorView = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50), type: .ballRotateChase, color: UIColor.darkGray, padding: .zero)
        view.addSubview(activityIndicatorView)
        view.isUserInteractionEnabled = false
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
    }
    
    func unlock() {
        DispatchQueue.main.async {
            if let indicator = self.view.subviews.first(where: {$0 is NVActivityIndicatorView }) as? NVActivityIndicatorView {
                indicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                indicator.removeFromSuperview()
            }
        }
    }
}

