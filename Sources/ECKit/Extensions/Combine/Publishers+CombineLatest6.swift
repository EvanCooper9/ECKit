import Combine

public extension Publishers {
    struct CombineLatest6<A, B, C, D, E, F, Z: Error>: Publisher {

        public typealias Output = (A, B, C, D, E, F)
        public typealias Failure = Z

        private let a: any Publisher<A, Z>
        private let b: any Publisher<B, Z>
        private let c: any Publisher<C, Z>
        private let d: any Publisher<D, Z>
        private let e: any Publisher<E, Z>
        private let f: any Publisher<F, Z>

        public init(
            _ a: any Publisher<A, Z>,
            _ b: any Publisher<B, Z>,
            _ c: any Publisher<C, Z>,
            _ d: any Publisher<D, Z>,
            _ e: any Publisher<E, Z>,
            _ f: any Publisher<F, Z>) {
                self.a = a
                self.b = b
                self.c = c
                self.d = d
                self.e = e
                self.f = f
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Z == S.Failure, (A, B, C, D, E, F) == S.Input {
            let firstFour = Publishers
                .CombineLatest4(
                    a.eraseToAnyPublisher(),
                    b.eraseToAnyPublisher(),
                    c.eraseToAnyPublisher(),
                    d.eraseToAnyPublisher()
                )

            let nextTwo = Publishers
                .CombineLatest(
                    e.eraseToAnyPublisher(),
                    f.eraseToAnyPublisher()
                )

            Publishers
                .CombineLatest(firstFour, nextTwo)
                .map { firstFourResults, nextTwo in
                    (
                        firstFourResults.0,
                        firstFourResults.1,
                        firstFourResults.2,
                        firstFourResults.3,
                        nextTwo.0,
                        nextTwo.1
                    )
                }
                .subscribe(subscriber)
        }
    }
}

