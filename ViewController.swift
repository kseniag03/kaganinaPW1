//
//  ViewController.swift
//  kaganinaPW1
//
//  Created by Ксения Ганина on 27.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ourView: UIView!
    @IBOutlet var views: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ourView.backgroundColor = .white
        ourView.layer.cornerRadius = 40
    }

    @IBAction func changeButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
                button?.isEnabled = false
        
        func GetColor(num: Int) -> UIColor {
            var color: UIColor
            switch num {
            case 1:
                color = UIColor(
                    hue: .random(in: 200...360) / 360,
                    saturation: .random(in: 0...1),
                    brightness: .random(in: 0...1),
                    alpha: 1
                )
            case 2:
                color = UIColor(
                    hue: .random(in: 110...210) / 360,
                    saturation: .random(in: 0...1),
                    brightness: .random(in: 0...1),
                    alpha: 1
                )
            case 3:
                color = UIColor(
                    hue: .random(in: 0...55) / 360,
                    saturation: .random(in: 0...1),
                    brightness: .random(in: 0...1),
                    alpha: 1
                )
            default:
                color = UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            }
            return color
        }
        
        let num: Int = Int.random(in: 0...3)
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(GetColor(num: num))
        }
        
        func GetRandomRadius(view: UIView) -> CGFloat {
                    CGFloat.random(in: 1...view.bounds.height / 2)
                }
        
        UIView.animate(withDuration: 2, animations: {
            for view in self.views {
                view.layer.cornerRadius = GetRandomRadius(view: view)
                view.backgroundColor = set.popFirst()
            }
        }) { completion in
            button?.isEnabled = true
        }
    }
    
    @IBAction func changeHexButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
                button?.isEnabled = false
        
        func GetHex() -> String {
            let nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            let letters = ["A", "B", "C", "D", "E", "F"]
            var randColor = ""
            while randColor.count != 6 {
                let num: Int = Int.random(in: 0...1)
                if (num == 0) {
                    randColor.append(nums[Int.random(in: 0...9)])
                } else {
                    randColor.append(letters[Int.random(in: 0...5)])
                }
            }
            return randColor
        }
        
        func GetUIColor(hex: String) -> UIColor {
            var rgb: UInt64 = 0
            guard Scanner(string: hex).scanHexInt64(&rgb) else { return UIColor(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 1
            ) }
            
            let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
            let g = CGFloat((rgb & 0xFF00) >> 8) / 255
            let b = CGFloat((rgb & 0xFF)) / 255
            
            return UIColor(
                red: r,
                green: g,
                blue: b,
                alpha: 1
            )
        }
        
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(GetUIColor(hex: GetHex()))
        }
        
        func GetRandomRadius(view: UIView) -> CGFloat {
                    CGFloat.random(in: 1...view.bounds.height / 2)
                }
        
        UIView.animate(withDuration: 2, animations: {
            for view in self.views {
                view.layer.cornerRadius = GetRandomRadius(view: view)
                view.backgroundColor = set.popFirst()
            }
        }) { completion in
            button?.isEnabled = true
        }
    }
}
