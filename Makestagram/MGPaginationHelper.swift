//
//  MGPaginationHelper.swift
//  Makestagram
//
//  Created by Chenyang Zhang on 6/30/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation

protocol MGKeyed{
    var key: String? { get set }
    
}


class MGPaginationHelper<T: MGKeyed> {
    enum MGPaginationState {
        case initial
        case ready
        case loading
        case end
    }
    let pageSize: UInt
    let serviceMethod: (UInt, String?, @escaping (([T]) -> Void)) -> Void
    var state: MGPaginationState = .initial
    var lastObjectKey: String?
    
    init(pageSize: UInt = 3, serviceMethod: @escaping (UInt, String?, @escaping (([T]) -> Void)) -> Void) {
        self.pageSize = pageSize
        self.serviceMethod = serviceMethod
    }
    // 1
    func paginate(completion: @escaping ([T]) -> Void) {
        // 2
        switch state {
        // 3
        case .initial:
            lastObjectKey = nil
            fallthrough
            
        // 4
        case .ready:
            state = .loading
            serviceMethod(pageSize, lastObjectKey) { [unowned self] (objects: [T]) in
                // 5
                defer {
                    // 6
                    if let lastObjectKey = objects.last?.key {
                        self.lastObjectKey = lastObjectKey
                    }
                    
                    // 7
                    self.state = objects.count < Int(self.pageSize) ? .end : .ready
                }
                
                // 8
                guard let _ = self.lastObjectKey else {
                    return completion(objects)
                }
                
                // 9
                let newObjects = Array(objects.dropFirst())
                completion(newObjects)
            }
            
        // 10
        case .loading, .end:
            return
        }
    }
    func reloadData(completion: @escaping ([T]) -> Void) {
        state = .initial
        paginate(completion: completion)
    }
}
