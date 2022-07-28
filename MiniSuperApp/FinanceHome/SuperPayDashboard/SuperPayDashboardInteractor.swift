//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by yeonBlue on 2022/07/25.
//

import ModernRIBs

protocol SuperPayDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashboardPresentable: Presentable {
    var listener: SuperPayDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SuperPayDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

/// 생성자 초기화 보다는 프로토콜로 필요한 객체를 이곳에 정이
protocol SuperPayDashboardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {

    weak var router: SuperPayDashboardRouting?
    weak var listener: SuperPayDashboardListener?
    private let dependancy: SuperPayDashboardInteractorDependency
    
    init(presenter: SuperPayDashboardPresentable,
                  dependancy: SuperPayDashboardInteractorDependency) {
        self.dependancy = dependancy
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
