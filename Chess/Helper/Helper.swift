//
//  Helper.swift
//  Chess
//
//  Created by Philips Jose on 11/11/25.
//
import Foundation

class Helper {
    static func readFromFileAsLines(fileName: String, fileExtension: String) -> [String]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
            print("Error: File \(fileName) with extension \(fileExtension) not found in bundle.")
            return nil
        }
        let fileURL = URL(fileURLWithPath: path)
        var storage: [String] = []
        do {
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = fileContents.components(separatedBy: .newlines)
            for line in lines {
                let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmedLine.isEmpty { continue }
                storage.append(trimmedLine)
            }
            return storage
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
    
    static func parseFromLine(_ line: String, componentCount: Int) -> [String]? {
        let components = line.components(separatedBy: ",")
        guard components.count == componentCount else {
            print("Skipping malformed line: \(line)")
            return nil
        }
        return components
    }
    
    static func getFileNameComponents(_ file: String) -> [String]? {
        let components = file.components(separatedBy: ".")
        guard components.count == 2 else { return nil}
        return components
    }
}
