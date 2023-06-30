import Combine

public extension Publishers {

    @available(iOS 16.0.0, *)
    struct ZipMany<Element, F: Error>: Publisher {
        public typealias Output = [Element]
        public typealias Failure = F

        private let upstreams: [any Publisher<Element, F>]

        public init(_ upstreams: [any Publisher<Element, F>]) {
            self.upstreams = upstreams
        }

        public func receive<S: Subscriber>(subscriber: S) where Self.Failure == S.Failure, Self.Output == S.Input {
            let initial = Just<[Element]>([])
                .setFailureType(to: F.self)
                .eraseToAnyPublisher()

            let zipped = upstreams.reduce(into: initial) { result, upstream in
                result = result.zip(upstream.eraseToAnyPublisher()) { elements, element in
                    elements + [element]
                }
                .eraseToAnyPublisher()
            }

            zipped.subscribe(subscriber)
        }
    }
}
