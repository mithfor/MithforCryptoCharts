//
//  LocalFileManager.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 15.11.2024.
//

import Foundation
import SwiftUI

class LocalFileManager {

    enum FileManagerError: LocalizedError {
        case badImageData
        case badImageURL
        case imageSavingError
    }
    static let instance = LocalFileManager()

    private init() { }

    func saveImage(image: UIImage, imageName: String, folderName: String) throws {

        createFolderIfNeeded(folderName: folderName)

        guard let data = image.pngData() else { throw FileManagerError.badImageData }
        guard let url = urlFor(imageName: imageName, folderName: folderName) else { throw FileManagerError.badImageURL }

        do {
            try data.write(to: url)
        } catch let error {
            print("\(FileManagerError.imageSavingError.localizedDescription). ImageName: \(imageName)")
            throw FileManagerError.imageSavingError
        }
    }

    // MARK: - Private funcs

    private func createFolderIfNeeded(folderName: String) {
        guard let url = urlFor(folder: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
        }
    }

    private func urlFor(folder: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask).first else { return nil }

        return url.appendingPathComponent(folder)
    }

    private func urlFor(imageName: String, folderName: String) -> URL? {
        guard let folderURL = urlFor(folder: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }

}
