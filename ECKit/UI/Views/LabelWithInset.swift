import UIKit

public final class LabelWithInset: UILabel {
    
    public var inset: CGFloat = 0 {
        didSet { textInsets = .init(top: inset, left: inset, bottom: inset, right: inset) }
    }
    
    public var textInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0) {
        didSet { setNeedsDisplay() }
    }
    
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += textInsets.left + textInsets.right
        size.height += textInsets.top + textInsets.bottom
        return size
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.width += textInsets.left + textInsets.right
        size.height += textInsets.top + textInsets.bottom
        return size
    }
}
