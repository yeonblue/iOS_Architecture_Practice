import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

// 자식 리블렛 builder는 부모가 가짐(트리)
final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashboardDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
    private let balancePublisher: CurrentValuePublisher<Double>
    
    init(dependency: FinanceHomeDependency,
         balancePublisher: CurrentValuePublisher<Double>) {
        self.balancePublisher = balancePublisher
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
  
  override init(dependency: FinanceHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
    let balancePublisher = CurrentValuePublisher<Double>(0)
      
    let component = FinanceHomeComponent(dependency: dependency, balancePublisher: balancePublisher)
    let viewController = FinanceHomeViewController()
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener
     
    // 자식 리블렛 builder
    let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
      
    return FinanceHomeRouter(interactor: interactor,
                             viewController: viewController,
                             superPayDashBoardBuildable: superPayDashboardBuilder)
  }
}
