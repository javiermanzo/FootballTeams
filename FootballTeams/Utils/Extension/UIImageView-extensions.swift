//
//  UIImageView-extensions.swift
//  FootballTeams
//
//  Created by Javier Manzo on 19/01/2023.
//

import UIKit
import Kingfisher
import PocketSVG

extension UIImageView {
    func setRemoteImage(url: URL, placeHolder: UIImage? = nil, animated: Bool = true) {
        var options: KingfisherOptionsInfo = []
        
        if animated {
            options.append(.transition(.fade(0.4)))
        }
        
        if url.pathExtension == "svg" {
            let processor = SVGProcessor(size: self.bounds.size)
            options.append(.processor(processor))
        }
        
        self.kf.setImage(with:url, placeholder: placeHolder, options: options)
    }
}

fileprivate struct SVGProcessor: ImageProcessor {
    
    let identifier = "svgprocessor"
    var size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
    
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> UIImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            if let svgString = String(data: data, encoding: .utf8) {
                let path = SVGBezierPath.paths(fromSVGString: svgString)
                let layer = SVGLayer()
                layer.paths = path
                let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                layer.frame = frame
                let img = self.snapshotImage(for: layer)
                return img
            }
            return nil
        }
    }
    
    func snapshotImage(for view: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
