import ModernRIBs

// 모든 비즈니스 로직의 시작점(Interactor)

protocol FinanceHomeRouting: ViewableRouting { // 자식 리블렛 붙일 함수 선언
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    
    func attachSuperPayDashboard()
}

protocol FinanceHomePresentable: Presentable {
    var listener: FinanceHomePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FinanceHomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener {
    
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FinanceHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSuperPayDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
