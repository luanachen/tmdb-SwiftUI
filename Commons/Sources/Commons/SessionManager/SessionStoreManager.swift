//
//  SessionStoreManager.swift
//  ApplaudoTest_Luana
//
//  Created by Luana Chen Chih Jun on 10/03/21.
//

import Foundation
import Security

public protocol SessionStoreManagerType {
    func save(key: String, data: Data) -> OSStatus
    func load(key: String) -> Data?
}

public class SessionStoreManager: SessionStoreManagerType {
    
    public init() {}

    public func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    public func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        return status == noErr ? dataTypeRef as? Data : nil
    }
}

public extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
