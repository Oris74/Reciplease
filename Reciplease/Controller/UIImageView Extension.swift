//
//  UIImageView Extension.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 10/11/2020.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        let photoURL = URL(string: url)
        guard let depackedPhotoURL = photoURL else {
            return self.image = UIImage(named: "noPhoto.png")
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: depackedPhotoURL),
               let image = UIImage(data: data) {

                DispatchQueue.main.async {
                    self?.image = image
                    self?.gradated()
                }
            } else {
                self?.image = UIImage(named: "noPhoto.png")
            }
        }
    }
    func gradated() {
        let gradientMaskLayer       = CAGradientLayer()
        gradientMaskLayer.frame     = bounds
        gradientMaskLayer.contents = self.image?.cgImage
        gradientMaskLayer.colors    = [UIColor.green.cgColor, UIColor.blue.cgColor]
        gradientMaskLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientMaskLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(gradientMaskLayer, at: 0)
    }
}
