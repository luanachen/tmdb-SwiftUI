//
//  ImageManager.swift
//  ApplaudoTest_Luana
//
//  Created by Luana Chen Chih Jun on 11/03/21.
//

import Combine
import UIKit

class ImageManager {

    @Published var retrievedImage: UIImage?

    func loadImage(url: URL)  {
        let cachedFile = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )
        if let image = UIImage(contentsOfFile: cachedFile.path) {
            retrievedImage = image
            return
        }
        download(url: url, toFile: cachedFile) { (error) in
            let image = UIImage(contentsOfFile: cachedFile.path)
            self.retrievedImage = image
        }
    }

   private func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            guard let tempURL = tempURL else {
                completion(error)
                return
            }
            do {
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )
                completion(nil)
            }
            catch {
                completion(error)
            }
        }
        task.resume()
    }
}
