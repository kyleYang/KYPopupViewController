//
//  KYPopupViewController.swift
//  Pods
//
//  Created by Kyle on 2017/8/28.
//
//

import UIKit

public enum KYPopupType: Int {
    case alert
    case sheet
    case drop
    case custom
    case none
}

public typealias ky_completion =  () -> Void

open class KYPopupViewController: UIViewController {

    fileprivate var isInitialized : Bool = false

    internal var buttons = [KYPopupButton]()

    internal var contentView : KYBaseContentView!
    internal var contentYConstraint : NSLayoutConstraint!

    internal var presentationManager: KYPopupPresentationManager!
    internal lazy var interactor = KYPopupInteractiveTransition()

    internal var completion : (() -> Void)? = nil
    
    internal var containerView : KYPopupContainerView{
        return view as! KYPopupContainerView
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        presentationManager = KYPopupPresentationManager(transitionStyle: .bounceUp, interactor: interactor)
        interactor.viewController = self

        transitioningDelegate = presentationManager
        modalPresentationStyle = .custom
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard !isInitialized else { return }
        setupViews()
        isInitialized = true
    }


    open override func loadView() {
        view = KYPopupContainerView(frame: UIScreen.main.bounds)
    }

    //setupView
    internal func setupViews(){


        for button in self.buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }

    //MARK: private method
    @objc fileprivate func buttonTapped(_ button: KYPopupButton) {
        if button.dismissOnTap {
            dismiss() { button.buttonAction?() }
        } else {
            button.buttonAction?()
        }
    }
    //public method
    open func addButton(_ button :KYPopupButton ){
        self.buttons.append(button);
    }

    open func addButtons(_ buttons :[KYPopupButton]){
        self.buttons.append(contentsOf: buttons)
    }

    open func bePresented(viewcontroller : UIViewController? = nil, animated:Bool = true,completion:ky_completion?=nil){

        var currentVC : UIViewController?
        if let _ = viewcontroller {
            currentVC = viewcontroller!
        }else{
            currentVC = UIWindow.topViewController()
        }

        currentVC?.present(self, animated: animated, completion: {
            completion?()
        })

    }

    public func dismiss(_ completion: ky_completion? = nil) {
        self.dismiss(animated: true) {
            completion?()
        }
    }


    

}
