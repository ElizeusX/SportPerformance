//
//  ProgressHud.swift
//  SportPerformance
//
//  Created by Elizeus Chrabrov on 12.12.2023.
//

import Foundation
import Combine
import ProgressHUD

enum ProgressHudState: Equatable {
    case showProgress
    case showSuccess
    case hideProgress
}

final class ProgressHudBinding {

    private var subscriptions: Set<AnyCancellable> = []

    init(state: Published<ProgressHudState>.Publisher) {
        state
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .showProgress: ProgressHUD.progress(1, interaction: false)
                case .showSuccess: ProgressHUD.succeed()
                case .hideProgress: ProgressHUD.dismiss()
                }
            }
            .store(in: &subscriptions)
    }
}
