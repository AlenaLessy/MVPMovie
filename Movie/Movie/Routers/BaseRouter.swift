// BaseRouter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол базового роутера
protocol BaseRouter {
    var navigationController: UINavigationController? { get set }
    var assemblyModuleBuilder: AssemblyBuilderProtocol? { get set }
}
