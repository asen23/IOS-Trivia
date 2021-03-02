//
//  HomeViewModel.swift
//  Learn IOS AM
//
//  Created by IT-Mobile-Dev on 02/03/21.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel{
    public struct Input{
        let loadRelay: Driver<Void>
    }
    public struct Output{
        let data: Driver<ResponseDetail>
    }
    
    public func getNextQuestion(input: HomeViewModel.Input) -> HomeViewModel.Output {
        
        let data = input.loadRelay.flatMapLatest{ _ -> Driver<ResponseDetail> in
            return HomeNetworkProvider.shared.getQuestion().asDriverOnErrorJustComplete()
        }

        return Output(data: data)
    }
}
