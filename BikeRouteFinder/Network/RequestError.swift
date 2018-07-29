//
//  RequestError.swift
//  Artemest
//


import Foundation

/// Common errors that can occur based on response status codes.
internal enum RequestError: Error {
    case osError(Error)
    case noResponse
    case corruptedResponse
    case notFound
    case badRequest
    case serverError
    case unauthorized
    case describedError(String)
    
    /// Initializes a new instance of RequestError.
    /// - Parameters
    ///     - code: HTTP status code.
    ///     - response: a response associated with the passed error. Used for debugging.
    init?(code: Int, response: URLResponse?) {
        switch code {
        case 404:
            self = .notFound
        case 401:
            self = .unauthorized
        case 400...499:
            self = .badRequest
        case 500...599:
            self = .serverError
        default:
            return nil
        }
    }
}
