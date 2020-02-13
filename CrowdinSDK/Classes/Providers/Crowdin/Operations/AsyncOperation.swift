//
//  AsyncOperation.swift
//  BaseAPIPackageDescription
//
//  Created by Serhii Londar on 5/19/18.
//
import Foundation

public protocol AnyAsyncOperation {
    var failed: Bool { get }
    var state: AsyncOperation.State { get }
    func finish(with fail: Bool)
}

public class AsyncOperation: Operation, AnyAsyncOperation {
    public var failed: Bool = false
    public enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + self.rawValue.capitalized
        }
    }
    public var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    override public var isReady: Bool {
        return super.isReady && state == .ready
    }
    override public var isExecuting: Bool {
        return state == .executing
    }
    override public var isFinished: Bool {
        return state == .finished
    }
    override public var isAsynchronous: Bool {
        return true
    }
    override public func start() {
        if isCancelled { state = .finished; return }
        guard !hasCancelledDependencies else{ cancel(); return }
        state = .executing
        main()
    }
    override public func main() {
        fatalError("Should be overriden in child class")
    }
    override func cancel() {
        state = .finished
    }
    func finish(with fail: Bool) {
        self.failed = fail
        state = .finished
    }
}

private extension AsyncOperation {
    var hasCancelledDependencies: Bool{
        return dependencies.reduce(false){ $0 || $1.isCancelled }
    }
}
