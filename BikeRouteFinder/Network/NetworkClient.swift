//
//  NetworkClient.swift
//  Artemest
//


import Foundation

internal protocol NetworkClient {
    
    /// Initializes a new instance of NetworkClient.
    /// - Parameters:
    ///     - requestBuilder: request builder you wish to use for request creation.
    ///     - authorizationController: a controller used to manage authorization of network requests.
    /// SeeAlso: RequestBuilder
    init(requestBuilder: RequestBuilder)
    
    /// Performs request to the API.
    /// - Parameters:
    ///     - request: APIRequest with all required configuration.
    ///     - completion: a completion block indicating if request succeed or failed.
    /// - Returns a RxSwift Single generic over APIRequest ResponseType associatedType.
    func perform<Request: APIRequest>(request: Request, completion: @escaping (Result<Request.ResponseType>) -> ())
    
    /// Cancels all requests that haven't completed yet.
    func cancelPendingRequests()
}
