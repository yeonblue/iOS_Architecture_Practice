//
//  SuperPayDashboardViewController.swift
//  MiniSuperApp
//
//  Created by yeonBlue on 2022/07/25.
//

import ModernRIBs
import UIKit

protocol SuperPayDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SuperPayDashboardViewController: UIViewController, SuperPayDashboardPresentable, SuperPayDashboardViewControllable {

    weak var listener: SuperPayDashboardPresentableListener?
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "슈퍼페이 현재 잔고"
        return label
    }()
    
    private lazy var topButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("충전하기", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        // self를 쓰기 위해서 lazy var로 선언
        btn.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .continuous // 좀 더 부드러운 커브
        view.backgroundColor = .systemMint
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "원"
        return label
    }()
    
    private let balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "12,345"
        return label
    }()
    
    private let balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    @objc func topButtonTapped() {
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        // headerStackView
        view.addSubview(headerStackView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(topButton)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        // cardView
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // balanceStackView
        cardView.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        balanceStackView.addArrangedSubview(currencyLabel)
        
        NSLayoutConstraint.activate([
            balanceStackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            balanceStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
}
