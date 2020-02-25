//
//  GitHubAPIService.swift
//  GitHubFollowers
//
//  Created by Robert Ramirez on 2/12/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct GitHubAPIService {
    static let shared = GitHubAPIService()
    private let decoder = JSONDecoder()
    private let imageCache = NSCache<NSString, UIImage>()

    public enum APIServiceError: Error {
        case apiError
        case invalidResponse
        case noData
        case decodeError
        case imageDataError
        case invalidURL
        case authenticationRequired
        case forbidden
        case notFound
    }

    func fetchUser(for username: String, completion: @escaping(Result<User, APIServiceError>) -> Void) {
        guard let userURL = URL(string: "https://api.github.com/users/\(username)") else { return }
        let urlRequest = URLRequest(url: userURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 1.0)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            if error != nil {
                completion(.failure(.apiError))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            switch response.statusCode {
            case 200:
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(.decodeError))
                }
            case 403:
                print("rate limited (60) exceeded by again in an hour")
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            default:
                completion(.failure(.noData))
            }

        }.resume()
    }

    func fetchAvatar(for avatarUrl: URL, completion: @escaping(Result<UIImage, APIServiceError>) -> Void) {

        if let cachedAvatarImage = imageCache.object(forKey: NSString(string: avatarUrl.absoluteString)) {
            //use cached avatar image
            completion(.success(cachedAvatarImage))
        } else {
            //create a new avatar image
            URLSession.shared.dataTask(with: avatarUrl) { data, _, error in

                if error != nil {
                    completion(.failure(.apiError))
                    return
                }

                guard let data =  data else {
                    completion(.failure(.noData))
                    return
                }

                guard let avatarImage = UIImage(data: data) else {
                    completion(.failure(.imageDataError))
                    return
                }
                self.imageCache.setObject(avatarImage, forKey: NSString(string: avatarUrl.absoluteString))
                completion(.success(avatarImage))
            }.resume()
        }

    }

    func fetchFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], APIServiceError>) -> Void ) {

        guard let followersURL = URL(string: "https://api.github.com/users/\(username)/followers?page=\(page)") else {
            completion(.failure(.invalidURL))
            return
        }
        let urlRequest = URLRequest(url: followersURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 1.0)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if error != nil {
                completion(.failure(.apiError))
                return
            }

            guard let response = response as? HTTPURLResponse, let data = data  else { return }

            switch response.statusCode {
            case 200:
                do {
                    let followers = try self.decoder.decode([Follower].self, from: data)
                    completion(.success(followers))
                } catch {
                    completion(.failure(.noData))
                }
            case 403:
                print("rate limited (60) exceeded by again in an hour")
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            default:
                completion(.success([]))
            }

        }.resume()
    }
}
