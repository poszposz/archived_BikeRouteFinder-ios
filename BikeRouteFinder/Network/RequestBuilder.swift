//
//  NetworkConfiguration.swift
//  Artemest
//


import Foundation

/// Base chemes for the requests.
internal enum Scheme: String {
    case http
    case https
}

/// Interface for objects used to create API request configuration.
internal protocol RequestBuilder {
    
    /// Initializes a new instance of RequestBuilder.
    /// - Parameters:
    ///     - scheme: a scheme indicating whether configuration should use http or https.
    ///     - host: base URL to the API.
    ///     - port: a port the API is operating on.
    /// - SeeAlso: Scheme
    init(scheme: Scheme, host: String, port: Int?)
    
    /// Prepare a URLRequest from API request.
    /// - Parameter request: APIRequest to create a URLRequest from.
    /// - Returns: URLRequest that can be passed exactly to URLSession.
    /// - SeeAlso: APIRequest
    func prepare<Request: APIRequest>(_ request: Request) -> URLRequest
}
