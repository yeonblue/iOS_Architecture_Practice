//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by yeonBlue on 2022/07/28.
//

import Combine
import CombineExt
import Foundation

// PassThroughtSubject - PublishSubject -> PublishRelay
// CurrentValueSubject - BehaviorSubject -> BehaviorRelay ( 초기값 존재 )

/// 사용하는 쪽에서 값을 읽기만 하는 용도(Subscribe 용)
public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    public typealias Output = Element
    public typealias Failure = Never
    
    fileprivate let currentValueRelay: CurrentValueRelay<Output>
    
    /// 현재 값 읽어오기 용도
    public var value: Element {
        return currentValueRelay.value
    }
    
    fileprivate init(_ initValue: Element) {
        currentValueRelay = CurrentValueRelay(initValue)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
        return currentValueRelay.receive(subscriber: subscriber)
    }
}

/// 값을 보내는 용도 사용 Publisher
public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    typealias Output = Element
    typealias Failure = Never
    
    public override init(_ initValue: Element) {
        super.init(initValue)
    }
    
    public func send(_ value: Element) {
        return currentValueRelay.accept(value)
    }
}
