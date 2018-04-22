/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

extension Request {
    public struct AcceptLanguage: Equatable {
        public let language: Language
        public let priority: Double

        public init(_ language: Language, priority: Double = 1.0) {
            self.language = language
            self.priority = priority
        }
    }
}
