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
        
        self.kf.cancelDownloadTask()
        self.kf.setImage(with:url, placeholder: placeHolder, options: options)
    }
    
    func requestRemoteImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        var options: KingfisherOptionsInfo = []
        
        if url.pathExtension == "svg" {
            if self.bounds.size == .zero {
                self.layoutIfNeeded()
            }
            let processor = SVGProcessor(size: self.bounds.size)
            options.append(.processor(processor))
        }
        
        let cache = ImageCache.default
        options.append(.targetCache(cache))
        
        ImageDownloader.default.downloadImage(with: url, options: options) { result in
            switch result {
            case .success(let value):
                cache.store(value.image, forKey: url.cacheKey)
                completion(value.image)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getMemoryCache(url: URL) -> UIImage?{
        let cache = ImageCache.default
        return cache.retrieveImageInMemoryCache(forKey: url.cacheKey)
    }
}

fileprivate struct SVGProcessor: ImageProcessor {
    
    let identifier = "svgprocessor"
    var size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
    
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> UIImage? {
        if self.size == .zero { return nil }
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            if data.count > 0, let svgString = String(data: data, encoding: .utf8) {
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
