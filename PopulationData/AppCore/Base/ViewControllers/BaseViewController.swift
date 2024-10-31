//
//  BaseViewController.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    // MARK: - Methods for Subclasses to Override

    func setupUI() {
    }

    func setupBindings() {
    }

    
}
