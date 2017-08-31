//
//  KYPopupButton.swift
//  Pods
//
//  Created by Kyle on 2017/8/29.
//
//

import UIKit

open class KYPopupButton: UIButton {

    public typealias buttonClosure = () -> Void

    // MARK: Public

    /// The font and size of the button title
    open dynamic var titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }

    /// The height of the button
    open dynamic var buttonHeight: Int

    /// The title color of the button
    open dynamic var titleColor: UIColor? {
        get { return self.titleColor(for: UIControlState()) }
        set { setTitleColor(newValue, for: UIControlState()) }
    }

    /// The background color of the button
    open dynamic var buttonColor: UIColor? {
        get { return backgroundColor }
        set { backgroundColor = newValue }
    }

    /// Default appearance of the button
    open var defaultTitleFont      = UIFont.systemFont(ofSize: 15)
    open var defaultTitleColor     = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
    open var defaultButtonColor    = UIColor.clear
    
    /// Whether button should dismiss popup when tapped
    open var dismissOnTap = true

    /// The action called when the button is tapped
    open fileprivate(set) var buttonAction: buttonClosure?



    // MARK: Initializers

    /*!
     Creates a button that can be added to the popup dialog

     - parameter title:         The button title
     - parameter dismisssOnTap: Whether a tap automatically dismisses the dialog
     - parameter action:        The action closure

     - returns: PopupDialogButton
     */
    public init(title: String,
                height: Int = 45,
                dismissOnTap: Bool = true, action: buttonClosure?) {

        // Assign the button height
        buttonHeight = height

        // Assign the button action
        buttonAction = action

        super.init(frame: .zero)

        // Set the button title
        setTitle(title, for: UIControlState())

        self.dismissOnTap = dismissOnTap

        // Setup the views
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View setup

    open func setupView() {

        // Default appearance
        setTitleColor(defaultTitleColor, for: UIControlState())
        titleLabel?.font              = defaultTitleFont
        backgroundColor               = defaultButtonColor

        // Add and layout views


        let views = ["button": self]
        let metrics = ["buttonHeight": buttonHeight]
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[button(buttonHeight)]", options: [], metrics: metrics, views: views)
        NSLayoutConstraint.activate(constraints)
    }
    
    open override var isHighlighted: Bool {
        didSet {

        }
    }
}
