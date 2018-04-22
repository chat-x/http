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
    public enum Authorization: Equatable {
        case basic(credentials: String)
        case bearer(credentials: String)
        case token(credentials: String)
        case custom(scheme: String, credentials: String)
    }
}
