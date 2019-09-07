//
//  AppBaseApi.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit
import York

class AppBaseApi {
    
    
    // MARK: - Properties
    
    let apiClient: YouTubeApiClient
    
    
    // MARK: - Initialization
    
    init(_ apiClient: YouTubeApiClient) {
        self.apiClient = apiClient
    }
    
    
    // MARK: - Helper methods
    
    public func get<Type, TransformerType>(
        _ targetUrl: String,
        responseTransformer: TransformerType,
        completionBlock: @escaping ((Type) -> Void),
        errorHandlerBlock: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.get(targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: nil,
                 completionBlock: completionBlock,
                 errorHandlerBlock: errorHandlerBlock,
                 retryAttempts: retryAttempts)
    }
    
    public func get<Type, TransformerType>(
        _ targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        completionBlock: @escaping ((Type) -> Void),
        errorHandlerBlock: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.get(self.apiClient.rootUrl,
                 targetUrl: targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: parameters,
                 completionBlock: completionBlock,
                 errorHandlerBlock: errorHandlerBlock,
                 retryAttempts: retryAttempts)
    }
    
    public func get<Type, TransformerType>(
        _ endpointUrl: String,
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        completionBlock: @escaping ((Type) -> Void),
        errorHandlerBlock: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        let urlString = endpointUrl + targetUrl
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = URL(string: urlString) else { return }
        let dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                if retryAttempts <= 1 {
                    errorHandlerBlock(error)
                } else {
                    self.get(endpointUrl,
                             targetUrl: targetUrl,
                             responseTransformer: responseTransformer,
                             parameters: parameters,
                             completionBlock: completionBlock,
                             errorHandlerBlock: errorHandlerBlock,
                             retryAttempts: retryAttempts - 1)
                }
            } else if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
                guard let data = data else { return }
                guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject else { return }
                
                let transformedObject = responseTransformer.transform(jsonData)
                completionBlock(transformedObject)
            }
        }
        
        dataTask.resume()
    }
    
}
