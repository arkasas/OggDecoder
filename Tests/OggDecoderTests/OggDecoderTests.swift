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
    }

    func test_decodeOgaAudioToWavAudio_shouldReturnTrue() throws {
        let ogaAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        XCTAssertTrue(decoder.decode(ogaAudioUrl, into: wavAudioUrl))
    }

    func test_decodeOggAudioToWavAudio_shouldReturnTrue() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin-polonaise-in-a-military", ext: "ogg")
        XCTAssertTrue(decoder.decode(oggAudioUrl, into: wavAudioUrl))
    }

    func test_decodeOggAudioToWavAudio_supportingAsynchronous_shouldReturnTrue() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin-polonaise-in-a-military", ext: "ogg")
        let decodingExpectation = expectation(description: "Decoded")
        decoder.decode(oggAudioUrl, into: wavAudioUrl) { result in
            XCTAssertTrue(result)
            decodingExpectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_decodeOgaAudioToWavAudio_supportingAsynchronous_shouldReturnTrue() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        let decodingExpectation = expectation(description: "Decoded")
        decoder.decode(oggAudioUrl, into: wavAudioUrl) { result in
            XCTAssertTrue(result)
            decodingExpectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_decodeOggAudioToWav_expectReturnFileUrl() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        XCTAssertNotNil(decoder.decode(oggAudioUrl))
    }
    
    func test_decodeOggAudioToWav_supportingAsynchronous_expectReturnFileUrl() throws {
        let oggAudioUrl = try fetchFileUrlFromTestBundle(filename: "TestResources/Chopin_-_Polonaise_Op._53", ext: "oga")
        let decodingExpectation = expectation(description: "Decoded")
        decoder.decode( oggAudioUrl) { result in
            XCTAssertNotNil(result)
            decodingExpectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    
    private func fetchFileUrlFromTestBundle(filename: String, ext: String) throws -> URL {
        let bundle = Bundle.module
        guard let fileUrl = bundle.url(forResource: filename, withExtension: ext) else {
            throw FileLoaderError.fileNotFound
        }

        return fileUrl
    }
}
