//
//  LoginPresenterProtocol.swift
//  MVP_ArchitectureExample
//
//  Created by nelime on 3/29/25.
//


import Foundation

protocol LoginPresenterProtocol {
    func login(username: String, password: String)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?

    init(view: LoginViewProtocol) {
        self.view = view
    }

    func login(username: String, password: String) {
        guard !username.isEmpty && !password.isEmpty else {
            view?.showError(message: "Username and Password cannot be empty.")
            return
        }

        view?.showLoading()

        // 간단한 로그인 로직 (예시용)
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                if username == "admin" && password == "1234" {
                    print("Login successful!")
                } else {
                    self?.view?.showError(message: "Invalid credentials.")
                }
            }
        }
    }
}
