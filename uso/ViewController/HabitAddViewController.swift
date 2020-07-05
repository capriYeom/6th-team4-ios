//
//  HabitAddViewController.swift
//  uso
//
//  Created by sooyong on 2020/05/16.
//  Copyright © 2020 sooyong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HabitAddViewController: UIViewController {
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var doneButton:UIButton!
    @IBOutlet var breadNameField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var sunView: UIButton!
    @IBOutlet var monView: UIButton!
    @IBOutlet var tueView: UIButton!
    @IBOutlet var wedView: UIButton!
    @IBOutlet var thrView: UIButton!
    @IBOutlet var friView: UIButton!
    @IBOutlet var satView: UIButton!
    @IBOutlet var alarmSwitch: UISwitch!
    @IBOutlet var timePicker: UIDatePicker!
    
    var dayBoolArr = [Bool](repeating: false, count: 7)
    var dayViewArr: [UIButton] = []
    weak var coordinator: MainCoordinator?
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayViewArr.append(sunView)
        dayViewArr.append(monView)
        dayViewArr.append(tueView)
        dayViewArr.append(wedView)
        dayViewArr.append(thrView)
        dayViewArr.append(friView)
        dayViewArr.append(satView)

        bindRX()
        layout()
    }

    func bindRX() {
        cancelButton.rx
            .tap
            .subscribe { _ in
                self.dismiss(animated: true, completion: nil)
            }
            .disposed(by: bag)
        
        doneButton.rx
        .tap
        .subscribe { _ in
            //API로 POST
        }
        .disposed(by: bag)
        
        alarmSwitch.rx
            .isOn
            .subscribe(onNext : {
                self.timePicker.isHidden = !$0
            })
            .disposed(by: bag)
    }

    @IBAction func tapDay(_ sender: UIButton) {
        guard let index = dayViewArr.firstIndex(of: sender) else {return}
        self.dayBoolArr[index].toggle()
        print(self.dayBoolArr)
        if self.dayBoolArr[index] {
            sender.backgroundColor = UIColor(hex: 0xAD9C82)
        } else {
            sender.backgroundColor = UIColor.white
        }
    }
}

extension HabitAddViewController: Storyboarded {
    func layout() {
        self.view.backgroundColor = UIColor(hex: 0xF5F4F1)
        breadNameField.addBorderBottom(width: breadNameField.bounds.width, height: 1, color: UIColor.label)
        descriptionField.addBorderBottom(width: breadNameField.bounds.width, height: 1, color: UIColor.label)
        dayViewArr.forEach {
            $0.backgroundColor = UIColor.white
            $0.layer.cornerRadius = $0.bounds.width/2
        }
        alarmSwitch.onTintColor = UIColor(hex: 0xAD9C82)
    }
}
