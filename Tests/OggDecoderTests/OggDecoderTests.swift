import XCTest
@testable import OggDecoder

final class OggDecoderTests: XCTestCase {
    enum FileLoaderError: Error {
        case fileNotFound
    }
    
    private var wavAudioUrl: URL!
    private var decoder: OGGDecoder!
    
    override func setUp() {
        super.setUp()
        
        decoder = OGGDecoder()
        do {
            wavAudioUrl = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
                .appendingPathComponent("out.wav")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        decoder = nil
        try? FileManager.default.removeItem(at: wavAudioUrl)
        wavAudioUrl = nil
        
        super.tearDown()
    }

    func test_whenDecodeOgaAudio_thenReturnTrue() throws {
        let ogaAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        XCTAssertTrue(decoder.decode(ogaAudioUrl, into: wavAudioUrl))
    }

    func test_whenDecodeOggAudio_thenReturnTrue() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin-polonaise-in-a-military", ext: "ogg")
        XCTAssertTrue(decoder.decode(oggAudioUrl, into: wavAudioUrl))
    }

    func test_whenDecodeOggAudio_supportingAsynchronous_thenReturnTrue() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin-polonaise-in-a-military", ext: "ogg")
        let decodingExpectation = expectation(description: "Decoded")
        decoder.decode(oggAudioUrl, into: wavAudioUrl) { result in
            XCTAssertTrue(result)
            decodingExpectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_whenDecodeOgaAudio_supportingAsynchronous_thenReturnTrue() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        let decodingExpectation = expectation(description: "Decoded")
        decoder.decode(oggAudioUrl, into: wavAudioUrl) { result in
            XCTAssertTrue(result)
            decodingExpectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_whenDecodeOgaAudio_thenReturnFileUrl() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        XCTAssertNotNil(decoder.decode(oggAudioUrl))
    }
    
    func test_whenDecodeOggAudio_supportingAsynchronous_thenReturnFileUrl() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        let decodingExpectation = expectation(description: "Decoded")
        decoder.decode(oggAudioUrl) { result in
            XCTAssertNotNil(result)
            decodingExpectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_decode_simulatingMultipleFiles() throws {
        let numberOfFiles = 100
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin-polonaise-in-a-military", ext: "ogg")
        let arrayOfFiles = Array(repeating: oggAudioUrl, count: numberOfFiles)
        let outputFiles = try (0..<numberOfFiles).map {
            try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
                .appendingPathComponent("out\($0).wav")
        }
        
        guard arrayOfFiles.count == outputFiles.count else {
            XCTFail("Range of input files is different than range of output files")
            return
        }
        
        let decodingExpectation = expectation(description: "Decoded")
        decodingExpectation.expectedFulfillmentCount = numberOfFiles
        
        var num = 0
        arrayOfFiles.enumerated().forEach {
            decoder.decode($0.element, into: outputFiles[$0.offset]) { result in
                print("test_decode_simulatingMultipleFiles = \(num)|\(result)")
                num += 1
                decodingExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 60)
    }

    
    private func fetchFileUrlFromTestBundle(filename: String, ext: String) throws -> URL {
        let bundle = Bundle.module
        guard let fileUrl = bundle.url(forResource: filename, withExtension: ext) else {
            throw FileLoaderError.fileNotFound
        }

        return fileUrl
    }
}
