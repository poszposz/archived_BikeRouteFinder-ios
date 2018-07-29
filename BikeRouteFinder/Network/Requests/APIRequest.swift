//
//  File.swift
//  Artemest
//


import Foundation

/// Common methods used in HTTP requests.
internal enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

/// All types of authorization that can be applied to requests.
/// - guest: uses a guest token not associated to any user.
/// - client: an autorization based on current user's credentials.
internal enum Authorization {
    case guest, client
}

/// Content Type to be set as a header.
/// - json: content type of application/json.
/// - html: content type of text/html.
internal enum ContentType: String {
    case json = "application/json"
    case html = "text/html"
}

/// A base protocol for creating requests. All requests conducted inside the application should conform to this protocol.
internal protocol APIRequest: Encodable {
    
    /// Type of response, that request raw response should be parsed to. Should conform to Decodable protocol.
    associatedtype ResponseType: Decodable
    
    /// Determines whether responsed should be cached.
    /// Defaults to false.
    var shouldUseCache: Bool { get }
    
    /// Indicates the type of authorization that should be applied to the request.
    /// Defaults to .client.
    var authorization: Authorization { get }
    
    /// Indicates what HTTP method should be used for specified request.
    /// Defaults to .GET
    var method: Method { get }
    
    /// Path to selected resources in the API. Should not contain base URL, for example /tests/all.
    var path: String { get }
    
    /// Query used to prepare the request.
    var query: String? { get }
    
    /// Indicates if the request should retry in case of failures.
    var shouldRetry: Bool { get }
    
    // Value indicating which content type should be set.
    var contentType: ContentType { get }
}

/// Default implemetation of some APIRequest variables.
internal extension APIRequest {
    
    var shouldUseCache: Bool {
        return false
    }
    
    var authorization: Authorization {
        return .client
    }
    
    var method: Method {
        return .GET
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var query: String? {
        return nil
    }
    
    var shouldRetry: Bool {
        return true
    }
    
    var contentType: ContentType {
        return .json
    }
}
