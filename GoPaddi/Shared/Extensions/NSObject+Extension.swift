//
//  NSObject+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import Foundation

protocol Weakifiable: AnyObject { }

extension NSObject: Weakifiable { }

extension Weakifiable {
    func weakify<T>(_ code: @escaping (Self, T) -> Void) -> (T) -> Void {
        return {
            [weak self] (data) in
            guard let self = self else { return }
            code(self, data)
        }
    }
    
    func weakify(_ code: @escaping (Self) -> ()) -> () -> () {
        return {
            [weak self] in
            guard let self = self else { return }
            code(self)
        }
    }
    
}
