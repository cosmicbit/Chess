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
            // 1. Read the entire file content as a single string
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            
            // 2. Split the string into individual lines
            let lines = fileContents.components(separatedBy: .newlines)
            
            // 3. Process each line
            for line in lines {
                // Ignore empty lines (often the last line)
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
}
