//
//  NetworkManager.swift
//  kumparan test
//
//  Created by Maurice Tin on 12/02/22.
//

import Foundation

class NetworkManager{
    
    enum CustomError: Error{
        case invalidURL
        case invalidData
    }
    
    func fetchData<T:Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void){
        
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
            
        let task = URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                    return
                } else{
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do{
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
        }
            task.resume()
    }
}
