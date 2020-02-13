//
//  LoginFeature.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/20/19.
//

import Foundation

public protocol CrowdinLoginProtocol {
	static var shared: Self? { get }
	static var isLogined: Bool { get }
	static func configureWith(with hash: String, loginConfig: CrowdinLoginConfig)
	
	func login(completion: @escaping () -> Void, error: @escaping (Error) -> Void)
	func relogin(completion: @escaping () -> Void, error: @escaping (Error) -> Void)
	func logout()
}

public final class CrowdinLogin: CrowdinLoginProtocol, CrowdinAuth {
	var config: CrowdinLoginConfig
	
	public static var shared: CrowdinLogin?
	
    private var loginAPI: LoginAPI
    
    public init(hash: String, config: CrowdinLoginConfig) {
		self.config = config
        self.loginAPI = LoginAPI(clientId: config.clientId, clientSecret: config.clientSecret, scope: config.scope, redirectURI: config.redirectURI, organizationName: config.organizationName)
        if self.hash != hash {
            self.logout()
        }
        self.hash = hash
        NotificationCenter.default.addObserver(self, selector: #selector(receiveUnautorizedResponse), name: .CrowdinAPIUnautorizedNotification, object: nil)
	}
	
    public static func configureWith(with hash: String, loginConfig: CrowdinLoginConfig) {
        CrowdinLogin.shared = CrowdinLogin(hash: hash, config: loginConfig)
	}
    
    var hash: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "crowdin.hash.key")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "crowdin.hash.key") ?? ""
        }
    }
	
	var tokenExpirationDate: Date? {
		set {
			UserDefaults.standard.set(newValue, forKey: "crowdin.tokenExpirationDate.key")
			UserDefaults.standard.synchronize()
		}
		get {
			return UserDefaults.standard.object(forKey: "crowdin.tokenExpirationDate.key") as? Date
		}
	}
	
	var tokenResponse: TokenResponse? {
		set {
			let data = try? JSONEncoder().encode(newValue)
			UserDefaults.standard.set(data, forKey: "crowdin.tokenResponse.key")
			UserDefaults.standard.synchronize()
		}
		get {
			guard let data = UserDefaults.standard.data(forKey: "crowdin.tokenResponse.key") else { return nil }
			return try? JSONDecoder().decode(TokenResponse.self, from: data)
		}
	}
	
	public static var isLogined: Bool {
		return shared?.tokenResponse?.accessToken != nil && shared?.tokenResponse?.refreshToken != nil
	}
	
	public var accessToken: String? {
		guard let tokenExpirationDate = tokenExpirationDate else { return nil }
		if tokenExpirationDate < Date() {
            if let refreshToken = tokenResponse?.refreshToken, let response = loginAPI.refreshTokenSync(refreshToken: refreshToken) {
                self.tokenExpirationDate = Date(timeIntervalSinceNow: TimeInterval(response.expiresIn))
                self.tokenResponse = response
            } else {
                logout()
            }
		}
		return tokenResponse?.accessToken
	}
    
    public func login(completion: @escaping () -> Void, error: @escaping (Error) -> Void) {
        loginAPI.login(completion: { (tokenResponse) in
            self.tokenExpirationDate = Date(timeIntervalSinceNow: TimeInterval(tokenResponse.expiresIn))
            self.tokenResponse = tokenResponse
        }, error: error)
	}
	
	public func relogin(completion: @escaping () -> Void, error: @escaping (Error) -> Void) {
		logout()
		login(completion: completion, error: error)
	}
	
	public func logout() {
		tokenResponse = nil
		tokenExpirationDate = nil
	}
	
	public func hadle(url: URL) -> Bool {
        return loginAPI.hadle(url: url)
	}
    
    @objc func receiveUnautorizedResponse() {
        // Try to refresh token.
        if let refreshToken = tokenResponse?.refreshToken, let response = loginAPI.refreshTokenSync(refreshToken: refreshToken) {
            self.tokenExpirationDate = Date(timeIntervalSinceNow: TimeInterval(response.expiresIn))
            self.tokenResponse = response
        } else {
            logout()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
