import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {

    private let superPayDashBoardBuildable: SuperPayDashboardBuildable
    private var superPayRouting: Routing? // 자식 리블렛이 붙어있는지 확인용
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: FinanceHomeInteractable,
         viewController: FinanceHomeViewControllable,
         superPayDashBoardBuildable: SuperPayDashboardBuildable) {
        self.superPayDashBoardBuildable = superPayDashBoardBuildable
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashboard() {
        
        if superPayRouting != nil {
            return
        }
        // builder에서 build를 호출에 router를 받아야 함
        // 부모의 interactor가 lister 담당
        let router = superPayDashBoardBuildable.build(withListener: interactor)
        let dashboard = router.viewControllable
        
        // subview로 추가할 것
        viewController.addDashboard(dashboard)
        
        // 자식 라우터 추가
        self.superPayRouting = router
        attachChild(router)
    }
}
