//
//  ViewController.swift
//  Homework1
//
//  Created by Gleb Evlakhov on 20.09.2022.
//  Copyright © 2022 Gleb Evlakhov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private enum Constants {
        static let viewsNumber: CGFloat = 8
        static let verticalOffset: CGFloat = 50
        static let radius: CGFloat = 120.0
    }
    
    private enum Varuables {
        static var radiusDelta: CGFloat = 25
    }
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet var views: [UIView]!
    @IBOutlet var screen: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 15.0
        button.backgroundColor = UIColor.systemIndigo
        let delta: CGFloat = 2 * CGFloat.pi / Constants.viewsNumber
        var alpha: CGFloat = CGFloat.pi / Constants.viewsNumber
        for view in views {
            view.frame.size.width = CGFloat.random(in: 100...140)
            view.frame.size.height = CGFloat.random(in: 150...190)
            view.center = CGPoint(
                x: screen.center.x + Constants.radius * cos(alpha),
                y: screen.center.y - Constants.verticalOffset + Constants.radius * sin(alpha)
            )
            view.backgroundColor = UIColor.black
            view.layer.cornerRadius = Varuables.radiusDelta
            alpha += delta
        }
    }


    @IBAction func buttonOnPress(_ sender: Any) {
        func getRandomRGBValue() -> CGFloat {
            return CGFloat.random(in: 0...1)
        }
        
        func getRandomColor() -> UIColor {
            return UIColor(
            red: getRandomRGBValue(),
            green: getRandomRGBValue(),
            blue: getRandomRGBValue(),
            alpha: CGFloat.random(in: 0.5...1))
        }
        
        self.button.isEnabled = false
        var st = Set<UIColor>()
        while (st.count < views.count) {
            st.insert(getRandomColor())
        }
        
        UIView.animate(withDuration: 1.5, animations: {
            for view in self.views {
                view.backgroundColor = st.popFirst()
                view.layer.cornerRadius += Varuables.radiusDelta
            }
        }) {completion in
            self.button.isEnabled = true
        }
        
        Varuables.radiusDelta = -Varuables.radiusDelta
    }
}
