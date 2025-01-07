//
//  RegexSyntaxTests.swift
//  RegexHighlightingTests
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2022-12-14.
//
//  ---------------------------------------------------------------------------
//
//  © 2022-2024 1024jp
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import Testing
@testable import RegexHighlighting

struct RegexSyntaxTests {
    
    @Test func highlightBracket() throws {
        
        // -> Only the `]` at the first position will be evaluated as a character.
        
        let character = RegexSyntaxType.character
        
        #expect(character.ranges(in: "[abc]") == [NSRange(location: 1, length: 3)])
        #expect(character.ranges(in: "\\[a[a]") == [NSRange(location: 0, length: 2), NSRange(location: 4, length: 1)])
        #expect(character.ranges(in: "[a\\]]") == [NSRange(location: 2, length: 2), NSRange(location: 1, length: 3)])
        #expect(character.ranges(in: "[]]") == [NSRange(location: 1, length: 1)])
        #expect(character.ranges(in: "[a]]") == [NSRange(location: 1, length: 1)])
        #expect(character.ranges(in: "[]a]") == [NSRange(location: 1, length: 2)])
        #expect(character.ranges(in: "[a]b]") == [NSRange(location: 1, length: 1)])
        
        #expect(character.ranges(in: "[a] [b]") == [NSRange(location: 1, length: 1),
                                                    NSRange(location: 5, length: 1)])
        
        #expect(character.ranges(in: "[^a]") == [NSRange(location: 2, length: 1)])
        #expect(character.ranges(in: "[^^]") == [NSRange(location: 2, length: 1)])
        #expect(character.ranges(in: "[^]]") == [NSRange(location: 2, length: 1)])
        #expect(character.ranges(in: "[^]]]") == [NSRange(location: 2, length: 1)])
        #expect(character.ranges(in: "[^a]]") == [NSRange(location: 2, length: 1)])
        #expect(character.ranges(in: "[^]a]") == [NSRange(location: 2, length: 2)])
        #expect(character.ranges(in: "[^a]b]") == [NSRange(location: 2, length: 1)])
        
        // just containing ranges for `\[`
        #expect(character.ranges(in: "(?<=\\[)a]") == [NSRange(location: 4, length: 2)])
    }
        
     
    @Test func highlightSymbol() {
        
        let symbol = RegexSyntaxType.symbol
        
        #expect(symbol.ranges(in: "[abc]") == [NSRange(location: 0, length: 5)])
        #expect(symbol.ranges(in: "\\[a[a]") == [NSRange(location: 3, length: 3)])
        #expect(symbol.ranges(in: "[a\\]]") == [NSRange(location: 0, length: 5)])
        #expect(symbol.ranges(in: "[]]") == [NSRange(location: 0, length: 3)])
        #expect(symbol.ranges(in: "[a]]") == [NSRange(location: 0, length: 3)])
        #expect(symbol.ranges(in: "[]a]") == [NSRange(location: 0, length: 4)])
        #expect(symbol.ranges(in: "[a]b]") == [NSRange(location: 0, length: 3)])
        
        #expect(symbol.ranges(in: "[a] [b]") == [NSRange(location: 0, length: 3),
                                                 NSRange(location: 4, length: 3)])
        
        #expect(symbol.ranges(in: "[^a]") == [NSRange(location: 0, length: 4)])
        #expect(symbol.ranges(in: "[^^]") == [NSRange(location: 0, length: 4)])
        #expect(symbol.ranges(in: "[^]]") == [NSRange(location: 0, length: 4)])
        #expect(symbol.ranges(in: "[^]]]") == [NSRange(location: 0, length: 4)])
        #expect(symbol.ranges(in: "[^a]]") == [NSRange(location: 0, length: 4)])
        #expect(symbol.ranges(in: "[^]a]") == [NSRange(location: 0, length: 5)])
        #expect(symbol.ranges(in: "[^a]b]") == [NSRange(location: 0, length: 4)])
        
        // just containing ranges for `(?<=`, `(` and `)`
        #expect(symbol.ranges(in: "(?<=\\[)a]") == [NSRange(location: 0, length: 4),
                                                    NSRange(location: 0, length: 1),
                                                    NSRange(location: 6, length: 1)])
    }
}
