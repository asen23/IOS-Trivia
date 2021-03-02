//
//  HomeNetworkProvider.swift
//  Learn IOS AM
//
//  Created by IT-Mobile-Dev on 02/03/21.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

class HomeNetworkProvider {
    private let provider = MoyaProvider<HomeTarget>()
    public static let shared = HomeNetworkProvider()
     
    private init(){}
    
    public func getQuestion() -> Observable<ResponseDetail> {
        return self.provider.rx
            .request(.getQuestion)
            .filterSuccessfulStatusCodes()
            .map(HomeResponseWrapper.self)
            .map{
                $0.results?[0] ?? ResponseDetail()
            }
            .asObservable()
    }
}

extension ObservableType {
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }

    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
