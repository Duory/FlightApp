//
//  HighlightedButton.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class HighlightedButton: UIButton {
    var highlightedColor = UIColor.clear
    var defaultColor = UIColor.white
    var disabledColor = UIColor.lightGray

    override var isHighlighted: Bool {
        didSet {
            let animations = {
                self.backgroundColor = self.isHighlighted ? self.highlightedColor : self.defaultColor
            }
            UIView.animate(
                withDuration: 0.15,
                delay: 0,
                options: [ .beginFromCurrentState, .curveEaseOut ],
                animations: animations,
                completion: nil
            )
        }
    }

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? (isHighlighted ? highlightedColor : defaultColor) : disabledColor
        }
    }
}
