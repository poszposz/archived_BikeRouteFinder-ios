//
//  DefaultNetworkClient.swift
//  Artemest
//


import Foundation

/// Default implementation of NetworkClient.
internal final class DefaultNetworkClient: NetworkClient {
    
    /// Default URL session.
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()

    /// Request builder used to create requests configuration.
    private let requestBuilder: RequestBuilder
    
    /// Initializes a new instance of NetworkClient.
    /// - Parameter requestBuilder: request builder you wish to use for request creation.
    /// - SeeAlso: RequestBuilder
    init(requestBuilder: RequestBuilder) {
        self.requestBuilder = requestBuilder
    }
    
    /// Performs request to the API.
    /// - Parameters:
    ///     - request: APIRequest with all required configuration.
    ///     - completion: a completion block indicating if request succeed or failed.
    /// - Returns a RxSwift Single generic over APIRequest ResponseType associatedType.
    func perform<Request: APIRequest>(request: Request, completion: @escaping (Result<Request.ResponseType>) -> ()) {
        let urlRequest = self.requestBuilder.prepare(request)
        self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.error(RequestError.osError(error)))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    completion(.error(RequestError.noResponse))
                }
                return
            }
            if let responseError = RequestError(code: httpResponse.statusCode, response: response) {
                DispatchQueue.main.async {
                    completion(.error(responseError))
                }
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any], let error = json?["error"] as? String {
                DispatchQueue.main.async {
                    completion(.error(RequestError.describedError(error)))
                }
                return
            }
            do {
                let responseData = try JSONDecoder().decode(Request.ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.error(RequestError.corruptedResponse))
                }
            }
        }).resume()
    }
    
    /// Cancels all requests that haven't completed yet.
    internal func cancelPendingRequests() {
        session.getAllTasks {
            $0.forEach { task in
                task.cancel()
            }
        }
    }
    
    /// Invalidates all pending requests.
    deinit {
        session.invalidateAndCancel()
    }
}
