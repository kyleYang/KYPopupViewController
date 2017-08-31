//
//  KYAlertContentView.swift
//  Pods
//
//  Created by Kyle on 2017/8/29.
//
//

import UIKit

final public class KYAlertContentView: KYBaseContentView {

    // MARK: - Appearance

    /// The font and size of the title label
    public dynamic var titleFont: UIFont {
        get { return titleLabel.font }
        set { titleLabel.font = newValue }
    }

    /// The color of the title label
    public dynamic var titleColor: UIColor? {
        get { return titleLabel.textColor }
        set { titleLabel.textColor = newValue }
    }

    /// The text alignment of the title label
    public dynamic var titleTextAlignment: NSTextAlignment {
        get { return titleLabel.textAlignment }
        set { titleLabel.textAlignment = newValue }
    }

    /// The font and size of the body label
    public dynamic var messageFont: UIFont {
        get { return messageLabel.font }
        set { messageLabel.font = newValue }
    }

    /// The color of the message label
    public dynamic var messageColor: UIColor? {
        get { return messageLabel.textColor }
        set { messageLabel.textColor = newValue}
    }

    /// The text alignment of the message label
    public dynamic var messageTextAlignment: NSTextAlignment {
        get { return messageLabel.textAlignment }
        set { messageLabel.textAlignment = newValue }
    }

    // MARK: - Views

    /// The view that will contain the image, if set

    /// The title label of the dialog
    internal lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hex: 0x000000)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        return titleLabel
    }()

    /// The message label of the dialog
    internal lazy var messageLabel: UILabel = {
        let messageLabel = UILabel(frame: .zero)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor(hex: 0x333333)
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        return messageLabel
    }()

    /// The height constraint of the image view, 0 by default
    internal var titleLabelTopConstraint: NSLayoutConstraint?
    internal var messageLabelTopConstraint: NSLayoutConstraint?
    internal var messageLabelBottomConstraint: NSLayoutConstraint?
    internal var buttonTopConstraint: NSLayoutConstraint?

    internal var actionbuttons : [KYPopupButton]
    internal var title : String?
    internal var message : String?

    init( title: String?,
          message: String?,
          buttons:[KYPopupButton]){
        self.title = title
        self.message = message
        self.actionbuttons = buttons
        super.init(frame:.zero)


    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View setup

    internal override func setupViews() {
        // Self setup
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true

        // Add views
        addSubview(titleLabel)
        addSubview(messageLabel)

        titleLabel.text = self.title
        messageLabel.text = self.message

        // Layout views
        let views = ["titleLabel": titleLabel, "messageLabel": messageLabel] as [String : Any]
        var constraints = [NSLayoutConstraint]()

        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==20@900)-[titleLabel]-(==20@900)-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==20@900)-[messageLabel]-(==20@900)-|", options: [], metrics: nil, views: views)

        titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 30)
        messageLabelTopConstraint = NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 8)

        if self.actionbuttons.count == 1 {
            let button = self.actionbuttons[0]
            button.translatesAutoresizingMaskIntoConstraints = false;
            addSubview(button);
            buttonTopConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 40)
            constraints.append(buttonTopConstraint!)

            constraints.append(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0.0, constant: 180))
            constraints.append(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -15))
            constraints.append(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))

        }else if self.actionbuttons.count == 2{

            let buttonOne = self.actionbuttons[0]
            let buttonTwo = self.actionbuttons[1]
            buttonOne.translatesAutoresizingMaskIntoConstraints = false;
            addSubview(buttonOne);

            buttonTwo.translatesAutoresizingMaskIntoConstraints = false;
            addSubview(buttonTwo);

            buttonTopConstraint = NSLayoutConstraint(item: buttonOne, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 40)
            constraints.append(buttonTopConstraint!)

            constraints.append(NSLayoutConstraint(item: buttonOne, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0.0, constant: 110))
            constraints.append(NSLayoutConstraint(item: buttonOne, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -15))
            constraints.append(NSLayoutConstraint(item: buttonOne, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: -10))

            constraints.append(NSLayoutConstraint(item: buttonTwo, attribute: .width, relatedBy: .equal, toItem: buttonOne, attribute: .width, multiplier: 1.0, constant: 0))
            constraints.append(NSLayoutConstraint(item: buttonTwo, attribute: .centerY, relatedBy: .equal, toItem: buttonOne, attribute: .centerY, multiplier: 1.0, constant: 0))
            constraints.append(NSLayoutConstraint(item: buttonTwo, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 10))

        }else{
            fatalError("not support this number of button")
        }

        var messageTopValue : CGFloat = 0
        if let _ = title{
            titleLabelTopConstraint!.constant = 40
            messageTopValue = 8
        }else{
            titleLabelTopConstraint!.constant = 0
            messageTopValue = 40
        }

        if let _ = message {
            messageLabelTopConstraint!.constant = messageTopValue
        }else{
            messageLabelTopConstraint!.constant = 0
        }

        constraints.append(titleLabelTopConstraint!)
        constraints.append(messageLabelTopConstraint!)

        // Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}
