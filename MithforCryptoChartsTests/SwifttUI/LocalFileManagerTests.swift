//
//  LocalFileManagerTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitriy Voronin on 15.11.2024.
//

import Testing
import SwiftUI
@testable import MithforCryptoCharts

struct LocalFileManagerTests {

    let badImageURL = "BadURL"
    let validImage = UIImage(systemName: "questionmark") ?? UIImage()

    @Test func saveImage_throwsLocalFileManagerError() async throws {
        let sut = LocalFileManager.instance

        #expect(throws: LocalFileManager.FileManagerError.self, performing: {
            try sut.saveImage(image: UIImage(), urlString: "")
        })
    }

    @Test func saveImage_throwsImageSavingError() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let sut = LocalFileManager.instance

        #expect(throws: LocalFileManager.FileManagerError.imageSavingError, performing: {
            try sut.saveImage(image: validImage, urlString: badImageURL)
        })
    }

    @Test func saveImage_success() async throws {
        let sut = LocalFileManager.instance

        #expect()
    }

}

// MARK: - Helpers


