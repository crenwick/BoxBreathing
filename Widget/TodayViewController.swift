import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

  @IBOutlet weak var borderView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

    createBorderRing()
    createCircle()
  }

  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData

    completionHandler(.newData)
  }

  private func createBorderRing() -> Void {
    let circlePath = UIBezierPath(ovalIn: borderView.bounds)

    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = UIColor.black.cgColor
    shapeLayer.lineWidth = 2

    borderView.layer.addSublayer(shapeLayer)
  }

  private func createCircle() -> Void {
    let shapeLayer = CAShapeLayer()
    borderView.layer.addSublayer(shapeLayer)

    let smallCircle = UIBezierPath(ovalIn: borderView.bounds.insetBy(dx: 30, dy: 30)).cgPath
    let largeCircle = UIBezierPath(ovalIn: borderView.bounds.insetBy(dx: 5, dy: 5)).cgPath

    shapeLayer.path = smallCircle
    shapeLayer.fillColor = UIColor(red: 34 / 255,
                                   green: 111 / 255,
                                   blue: 160 / 255,
                                   alpha: 1).cgColor

    let animationGrow = CABasicAnimation(keyPath: "path")
    animationGrow.fromValue = smallCircle
    animationGrow.toValue = largeCircle
    animationGrow.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animationGrow.beginTime = 0
    animationGrow.duration = 4

    let animationStayBig = CABasicAnimation(keyPath: "path")
    animationStayBig.fromValue = largeCircle
    animationStayBig.toValue = largeCircle
    animationStayBig.beginTime = 4
    animationStayBig.duration = 4

    let animationShrink = CABasicAnimation(keyPath: "path")
    animationShrink.fromValue = largeCircle
    animationShrink.toValue = smallCircle
    animationShrink.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animationShrink.beginTime = 8
    animationShrink.duration = 4

    let animationGroup = CAAnimationGroup()
    animationGroup.animations = [animationGrow, animationStayBig, animationShrink]
    animationGroup.duration = 16
    animationGroup.repeatCount = .infinity

    shapeLayer.add(animationGroup, forKey: "path")
  }

}
