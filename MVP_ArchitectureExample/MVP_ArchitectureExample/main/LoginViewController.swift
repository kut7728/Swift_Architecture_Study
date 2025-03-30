//
//  LoginViewProtocol.swift
//  MVP_ArchitectureExample
//
//  Created by nelime on 3/29/25.
//


import UIKit

protocol LoginViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
}

class LoginViewController: UIViewController, LoginViewProtocol {
    // UI 컴포넌트 정의
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    var presenter: LoginPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = LoginPresenter(view: self)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        view.backgroundColor = .white
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

        // 레이아웃 설정 (간단히 오토레이아웃 적용)
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, activityIndicator])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            loginButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    @objc private func didTapLoginButton() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else { return }
        presenter?.login(username: username, password: password)
    }

    // LoginViewProtocol 구현
    func showLoading() {
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
