//
//  NSTextStorageTests.swift
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2024-06-19.
//
//  ---------------------------------------------------------------------------
//
//  © 2024 1024jp
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

import AppKit.NSTextStorage
import Testing

struct NSTextStorageTests {
    
    @Test func bigMutableString() {
        
        let string = NSTextStorage(string: String(repeating: "a", count: 512)).string
        let bigString = NSTextStorage(string: String(repeating: "a", count: 513)).string
        
        #expect((string as NSString).className == "__NSCFString")
        #expect((bigString as NSString).className == "NSBigMutableString")
        #expect(!(bigString.immutable as NSString).className.contains("Mutable"))
    }
}
