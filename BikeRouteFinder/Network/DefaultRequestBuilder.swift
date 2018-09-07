//
//  DefaultNetworkConfiguration.swift
//  Artemest
//


import Foundation

/// Default implementation of RequestBuilder.
internal struct DefaultRequestBuilder: RequestBuilder {
    
    /// Dafult timeout for all requests.
    private let defaultTimeoutInterval: TimeInterval = 90
    
    /// URL scheme determining whether use http or https.
    /// - SeeAlso: Scheme
    private let scheme: Scheme
    
    /// Base API host.
    private let host: String
    
    /// A port the API is operating on.
    private let port: Int?
    
    /// Computed property returning base url components to be appended with path.
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.port = port
        return components
    }
    
    /// Initializes a new instance of RequestBuilder.
    /// - Parameters:
    ///     - scheme: a scheme indicating whether configuration should use http or https.
    ///     - host: base URL to the API.
    ///     - port: a port the API is operating on.
    /// SeeAlso: Scheme
    init(scheme: Scheme, host: String, port: Int?) {
        self.scheme = scheme
        self.host = host
        self.port = port
    }
    
    /// Prepare a URLRequest from API request.
    /// - Parameter request: APIRequest to create a URLRequest from.
    /// - Returns: URLRequest that can be passed exactly to URLSession.
    /// - SeeAlso: APIRequest
    internal func prepare<Request>(_ request: Request) -> URLRequest where Request: APIRequest {
        var components = baseComponents
        components.path = request.path
        components.query = request.query
        assert(components.url != nil, "Could not create URL from components.")
        var urlRequest = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: defaultTimeoutInterval)
        let httpBody = try? JSONEncoder().encode(request)
        urlRequest.httpBody = httpBody
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }
}
