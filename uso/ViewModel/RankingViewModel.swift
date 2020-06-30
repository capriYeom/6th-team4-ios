//
//  RankingViewModel.swift
//  uso_ios
//
//  Created by Apple on 2020/04/28.
//  Copyright © 2020 sooyong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class RankingViewModel: ViewModelType {
    private var bag = DisposeBag()
    private var rankingRepo: RankingRepositoryProtocol = RankingRepository.shared
    
    func transform(input: Input) -> Output {
        let rankingItemOutput = PublishSubject<[RankingItem]>.init()
        
        input.viewModelExecuted
            .subscribe(onNext: { state in
//                switch state {
//                case .trigger:
//                    rankingRepo.fetchRepository(completion: RankingAPI.searchWithSwift(rankingItemOutput))
//                }
        }).disposed(by: self.bag)
        
        return Output(rankingItemOutput: rankingItemOutput)
    }
}

extension RankingViewModel {
    struct Input {
        var viewModelExecuted: PublishSubject<ViewModelExecution>
    }
    
    struct Output {
        var rankingItemOutput : PublishSubject<[RankingItem]>
    }
}
