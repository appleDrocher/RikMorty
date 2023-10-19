import UIKit

enum Request {
    case characters(name: String?, page: Int = 0)
    
    private var host: String {
        switch self {
        case .characters : return "https://rickandmortyapi.com/api/character/"
            
        }
    }
    
    private var parameters: [URLQueryItem] {
        switch self {
        case .characters(let name, let page):
            var temp: [URLQueryItem] = [.init(name: "page", value: page.description)]
            if let name {
                temp.append(.init(name: "name", value: name))
            }
            return temp
            
        }
    }
    private var url: URL? {
        return components?.url
    }
    
    private var components: URLComponents? {
        var components = URLComponents(string: host)
        components?.queryItems = parameters
        return components
    }
    
    fileprivate func build() throws -> URLRequest {
        guard let url else { throw Failure.badRequest }
        let request = URLRequest(url: url)
        return request
    }
}

struct Networker {
    public static let shared = Networker()
    public private(set) var session = URLSession(configuration: .ephemeral)
    
    private init() {}
    
    fileprivate func load(
        for url: URL
    ) async -> Data? {
        do {
            let (data, response) = try await session.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return nil
            }
            return data
        } catch {
            return nil
        }
    }
    
    public func get<Object>(
        object: Object.Type,
        for request: Request
    ) async throws -> Object
    where Object: Decodable {
        let request = try request.build()
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw Failure.badResponse
            }
            return try decode(object: Object.self, for: data)
        } catch {
            guard let failure = error as? Failure else {
                throw Failure.unknown(error.localizedDescription)
            }
            throw failure
        }
    }
    
    private func decode<Object>(
        object: Object.Type,
        for data: Data
    ) throws -> Object
    where Object: Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let object = try decoder.decode(Object.self, from: data)
            return object
        } catch {
            throw Failure.decode(error.localizedDescription)
        }
    }
}

enum Failure: Error {
    case badRequest
    case badResponse
    case decode(String)
    case unknown(String)
    
    var description: String {
        switch self {
        case .badRequest:
            return "Не удалось сформировать URL"
        case let .unknown(error):
            return "Ошибка: \(error)"
        case .badResponse:
            return "Плохой ответ сервера"
        case let .decode(error):
            return "Ошибка декодирования данных: \(error)"
        }
    }
}

extension UIImageView {
    public func load(for url: URL) async {
        guard let data = await Networker.shared.load(for: url) else { return }
        let image = UIImage(data: data)
        self.image = image
    }
}
