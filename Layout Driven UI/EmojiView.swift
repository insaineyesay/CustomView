//
//  EmojiView.swift
//  Layout Driven UI
//
//  Created by Yi Wang on 2/6/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

@IBDesignable
class EmojiView: UIView {

    private static let xibName = "EmojiView"

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!

    /// Possible states of feeling
    enum Feeling {
        case groovy
        case meh
    }

    /// State variable denoting the feeling of this view.
    var feeling: Feeling = Feeling.groovy {
        // Using property observer - didSet to dirty the layout everytime the feeling var changes state.
        didSet {
            // Triggers layoutSubViews at the next frame update
            setNeedsLayout()
        }
    }

    // Called after the view and its subviews were allocated and initialized. It is guaranteed that the view will have all its outlet instance variables set. If initWithCoder: is the beginning of the nib unarchiving process, then awakeFromNib is the end.
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // To init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // To init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(EmojiView.xibName, owner: self, options: nil)
        contentView.fixInView(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard emojiLabel != nil, feelingLabel != nil else { return }

        switch feeling {
        case .groovy:
            emojiLabel.text = "😎"
            feelingLabel.text = "Feeling Irie"
        case .meh:
            emojiLabel.text = "😐"
            feelingLabel.text = "Meh"
        }
    }

}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
