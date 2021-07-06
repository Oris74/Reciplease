//
//  UIImageView Extension.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 10/11/2020.
//

import UIKit

extension UIImageView {
    func load(url: String, activity: UIActivityIndicatorView) {
        let photoURL = URL(string: url)
        guard let depackedPhotoURL = photoURL else {
            return self.image = UIImage(named: "noPhoto.png")
        }
        activity.isHidden = false
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: depackedPhotoURL),
               let image = UIImage(data: data) {

                DispatchQueue.main.async {
                    self?.image = image

                    activity.isHidden = true
                }
            }
        }
    }
    func gradated() {
        let gradientMaskLayer = CAGradientLayer()
        let initialColor = UIColor.black.withAlphaComponent(0.0).cgColor
        let finalColor =  UIColor.black.withAlphaComponent(0.9).cgColor
        gradientMaskLayer.colors = [initialColor,finalColor]
        gradientMaskLayer.frame = self.frame
        self.layer.addSublayer(gradientMaskLayer)
    }
}
