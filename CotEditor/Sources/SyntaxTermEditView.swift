//
//  SyntaxTermEditView.swift
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2023-01-18.
//
//  ---------------------------------------------------------------------------
//
//  © 2023-2024 1024jp
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

import SwiftUI

struct SyntaxTermEditView: View {
    
    typealias Item = SyntaxDefinition.Term
    
    
    @Binding var terms: [Item]
    var helpAnchor: String = "syntax_highlight_settings"
    
    @State private var selection: Set<Item.ID> = []
    @FocusState private var focusedField: Item.ID?
    
    
    // MARK: View
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Table($terms, selection: $selection) {
                TableColumn(String(localized: "RE", table: "SyntaxEdit", comment: "table column header (RE for Regular Expression)")) { item in
                    Toggle(isOn: item.isRegularExpression, label: EmptyView.init)
                        .help(String(localized: "Regular Expression", table: "SyntaxEdit", comment: "tooltip for RE checkbox"))
                        .onChange(of: item.isRegularExpression.wrappedValue) { newValue in
                            guard self.selection.contains(item.id) else { return }
                            $terms
                                .filter(with: self.selection)
                                .filter { $0.id != item.id }
                                .forEach { $0.isRegularExpression.wrappedValue = newValue }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                }.width(20)
                
                TableColumn(String(localized: "IC", table: "SyntaxEdit", comment: "table column header (IC for Ignore Case)")) { item in
                    Toggle(isOn: item.ignoreCase, label: EmptyView.init)
                        .help(String(localized: "Ignore Case", table: "SyntaxEdit", comment: "tooltip for IC checkbox"))
                        .onChange(of: item.ignoreCase.wrappedValue) { newValue in
                            guard self.selection.contains(item.id) else { return }
                            $terms
                                .filter(with: self.selection)
                                .filter { $0.id != item.id }
                                .forEach { $0.ignoreCase.wrappedValue = newValue }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                }.width(20)
                
                TableColumn(String(localized: "Begin String", table: "SyntaxEdit", comment: "table column header")) { item in
                    RegexTextField(text: item.begin, showsError: true, showsInvisible: true)
                        .regexHighlighted(item.isRegularExpression.wrappedValue)
                        .style(.table)
                        .focused($focusedField, equals: item.id)
                }
                
                TableColumn(String(localized: "End String", table: "SyntaxEdit", comment: "table column header")) { item in
                    RegexTextField(text: item.end ?? "", showsError: true, showsInvisible: true)
                        .regexHighlighted(item.isRegularExpression.wrappedValue)
                        .style(.table)
                }
                
                TableColumn(String(localized: "Description", table: "SyntaxEdit", comment: "table column header")) { item in
                    TextField(text: item.description ?? "", label: EmptyView.init)
                }
            }
            .tableStyle(.bordered)
            .border(Color(nsColor: .gridColor))
            
            HStack {
                AddRemoveButton($terms, selection: $selection, focus: $focusedField)
                Spacer()
                HelpButton(anchor: self.helpAnchor)
            }
        }
    }
}



// MARK: - Preview

#Preview {
    @State var terms: [SyntaxDefinition.Term] = [
        .init(begin: "(inu)", end: "(dog)"),
        .init(begin: "[Cc]at", end: "$0", isRegularExpression: true, description: "note"),
        .init(begin: "[]", isRegularExpression: true, ignoreCase: true),
    ]
    
    return SyntaxTermEditView(terms: $terms)
        .padding()
}