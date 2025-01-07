//
//  OptionalMenu.swift
//  ControlUI
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2022-02-21.
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

import AppKit

/// A menu dynamically shows optional menu items by pressing the Option key.
///
/// Optional items should have an empty key equivalent and the Option key only modifier key.
public final class OptionalMenu: NSMenu, NSMenuDelegate {
    
    // MARK: Private Properties
    
    private var trackingTimer: Timer?
    private var isShowingOptionalItems = false
    
    
    // MARK: Lifecycle
    
    public required override init(title: String = "") {
        
        super.init(title: title)
        
        self.delegate = self
    }
    
    
    required init(coder: NSCoder) {
        
        super.init(coder: coder)
        
        self.delegate = self
    }
    
    
    // MARK: Menu Delegate Methods
    
    public func menuWillOpen(_ menu: NSMenu) {
        
        self.update()  // UI validation is performed here
        self.validateKeyEvent(forcibly: true)
        
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(validateKeyEvent), userInfo: nil, repeats: true)
        timer.tolerance = 0.05
        RunLoop.current.add(timer, forMode: .eventTracking)
        self.trackingTimer = timer
    }
    
    
    public func menuDidClose(_ menu: NSMenu) {
        
        self.trackingTimer?.invalidate()
        self.trackingTimer = nil
        self.updateOptionalItems(shows: false)
    }
    
    
    // MARK: Private Functions
    
    /// Checks the state of the modifier key press and update the item visibility.
    ///
    /// - Parameter forcibly: Whether forcing to update the item visibility.
    @objc private func validateKeyEvent(forcibly: Bool = false) {
        
        let shows = NSEvent.modifierFlags.contains(.option)
        
        guard forcibly || shows != self.isShowingOptionalItems else { return }
        
        self.updateOptionalItems(shows: shows)
    }
    
    
    /// Updates the visibility of optional items.
    ///
    /// - Parameter shows: `true` to show optional items.
    private func updateOptionalItems(shows: Bool) {
        
        for item in self.items {
            guard
                item.isEnabled,
                item.keyEquivalentModifierMask == .option,
                item.keyEquivalent.isEmpty
            else { continue }
            
            item.isHidden = (item.state == .off) && !shows
        }
        
        self.isShowingOptionalItems = shows
    }
}
