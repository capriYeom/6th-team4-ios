//
//  MyRankingTableViewCell.swift
//  uso
//
//  Created by 서재훈 on 2020/05/01.
//  Copyright © 2020 sooyong. All rights reserved.
//

import UIKit
import RxSwift

class MyRankingTableViewCell: UITableViewCell {
    static let identifier = "MyRankingTableViewCell"
    
    @IBOutlet var highRankLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var blankView: UIView!
    
    let onData: AnyObserver<RankingItem>
    var bag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        let data = PublishSubject<RankingItem>()
        onData = data.asObserver()
    
        super.init(coder: aDecoder)

        data.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] ranking in
                self?.totalLabel.text = "\(ranking.achievement)"
                self?.rankLabel.text = ranking.rank
                self?.highRankLabel.text = "\(Int(ranking.rank)!*100/ranking.achievement) %"
            })
            .disposed(by: bag)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func layout() {
        self.contentView.backgroundColor = UIColor(hex: 0xF5F4F1)
        blankView.backgroundColor = UIColor.systemBackground
        blankView.setRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 28)
        rankLabel.textColor = UIColor(hex: 0x4C7A65)
    }
    
}
