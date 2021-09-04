import Foundation

/// Protocol-delegate that converts templated string to regular. 
public protocol TemplatedMessageConverter {
    func convertToString(templated: String, arguments: [TypeWrapperRepresentable]) -> String
}
