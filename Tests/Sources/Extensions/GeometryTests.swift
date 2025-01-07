//
//  GeometryTests.swift
//  Tests
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2016-07-10.
//
//  ---------------------------------------------------------------------------
//
//  © 2016-2024 1024jp
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

import CoreGraphics
import Testing
@testable import CotEditor

struct GeometryTests {
    
    @Test func scale() {
        
        #expect(CGSize.unit.scaled(to: 0.5) == CGSize(width: 0.5, height: 0.5))
        #expect(CGPoint(x: 2, y: 1).scaled(to: 2) == CGPoint(x: 4, y: 2))
        #expect(CGRect(x: 2, y: 1, width: 2, height: 1).scaled(to: 2) ==
                CGRect(x: 4, y: 2, width: 4, height: 2))
    }
    
    
    @Test func rectMid() {
        
        #expect(CGRect(x: 1, y: 2, width: 2, height: 4).mid == CGPoint(x: 2, y: 4))
    }
    
    
    @Test func prefix() {
        
        #expect(-CGPoint(x: 2, y: 3) == CGPoint(x: -2, y: -3))
        #expect(-CGSize(width: 2, height: 3) == CGSize(width: -2, height: -3))
    }
    
    
    @Test func offset() {
        
        #expect(CGPoint(x: 2, y: 3).offsetBy(dx: 4, dy: 5) == CGPoint(x: 6, y: 8))
        #expect(CGPoint(x: 2, y: 3).offset(by: -CGPoint(x: 2, y: 3)) == .zero)
        #expect(CGPoint(x: 2, y: 3).offset(by: -CGSize(width: 2, height: 3)) == .zero)
    }
}
