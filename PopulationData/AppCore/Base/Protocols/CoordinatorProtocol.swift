//
//  CoordinatorProtocol.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    var navigationController: UINavigationController { get set }
    
    func start()

    func addChildCoordinator(_ coordinator: CoordinatorProtocol)

    func removeChildCoordinator(_ coordinator: CoordinatorProtocol)

    func pushViewController(_ viewController: UIViewController, animated: Bool)

    func presentViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    func popViewController(animated: Bool)
}
