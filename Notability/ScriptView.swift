//
//  ScriptView.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 16/11/22.
//

import SwiftUI
import RichTextKit

struct ScriptView: View {

    @State private var text: NSAttributedString = NSAttributedString(string: "")
    @State var text2: String = ""
    @StateObject var context = RichTextContext()
    @State private var color = Color.blue
    @State private var isText = true
    @State private var thickness: Double = 1.0
    @State private var currentLine = Line()
    @State private var update: Bool = false
    @State private var lines: [Line] = []
    
    @ObservedObject var vm: ViewModel
    let note: NoteEntity?  //= nil
    @State var title: String = ""
    @Environment(\.dismiss) var dismiss
    

    init(vm: ViewModel, note: NoteEntity? = nil) {
        self.vm = vm
        self.note = note
        if let note = note {
        self._text = State(initialValue: note.text ?? NSAttributedString(string: ""))
        print("init: \(note.text)")
            //text = /*note.text ??*/ NSAttributedString(string: "niente")
        }
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom, spacing: 30){ if isText == true {
                textControl
            } else {
                paintControl
            }
                
                Button {
                    if isText {
                        currentLine.color = color
                    } else {
                        color = currentLine.color
                    }
                    isText.toggle()
                    hideKeyboard()
                    
                    
                } label: {
                    Image(systemName: "pencil.tip.crop.circle")
                        .font(.title2)
                }
                
            }
            
            
            //.navigationTitle("Documents")
            
            .navigationBarTitleDisplayMode(.inline)
            ZStack {
                RichTextEditor(text: $text, context: context) {
                    $0.textContentInset = CGSize(width: 10, height: 20)
                }.padding(.horizontal)
                    .background(Color.clear)
                    .zIndex( isText ? 2 : 1)
                
                
                //            TextField("aaa", text: $text2)
                //            .toolbar {
                //                ToolbarItemGroup(placement: .keyboard) {
                //                    Button {
                //                        context.isUnderlined.toggle()
                //                    } label: {
                //                        Image(systemName: "underline")
                //                            .font(.title2)
                //                    }                }
                // }
                
                Paintview(lines: $lines, thickness: $thickness, currentLine: $currentLine)
                    .zIndex( isText ? 1 : 2)
            }
        }
        .onAppear {

            if let note = note {
                update = true
                print("fetch lines")
                lines = vm.fetchLines(entity: note)
            }
        }
        
        
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    print("TEXT: \(text)")
//                    guard let uiImage = ImageRenderer(content: ScriptView(vm: vm)).uiImage else {return}
//                    vm.addNote(text: text)
                    if update {
                        vm.updateNote(entity: note!, text: text)
                        vm.saveLines(lines: lines, entity: note!)
                        print("aggiorna")
                    } else {
                        vm.addNote(text: text, lines: lines)
                        print("Nuova")
                    }

                    text = NSAttributedString(string: "")
                    dismiss()
                    
                }, label: {
                    Text("Done")
                    
                }) .padding(.horizontal)
            }
            
        }
    }
}

struct ScriptView_Previews: PreviewProvider {

    static var previews: some View {

        ScriptView(vm: ViewModel())
           
    }
}
extension ScriptView {
    @ViewBuilder // per costruire una view
    private var textControl: some View {
        Button {
            context.decrementFontSize()
        } label: {
            Image(systemName: "textformat.size.smaller")
                .font(.title2)
                .padding(.top, 45)
        }
        Button {
            context.incrementFontSize()
        } label: {
            Image(systemName: "textformat.size.larger")
                .font(.title2)
        }
        
        Button {
            context.isBold = true
        } label: {
            Image(systemName: "bold")
                .font(.title2)
        }
        Button {
            context.isItalic = true
        } label: {
            Image(systemName: "italic")
                .font(.title2)
        }
        
        Button {
            if context.isUnderlined == true {
                context.isUnderlined = false
            } else {
                context.isUnderlined = true
            }
        } label: {
            Image(systemName: "underline")
                .font(.title2)
        }
        ColorPicker(selection: $color, supportsOpacity: false) {
        } //nascone il label
        .labelsHidden()
        .onChange(of: color) { color in
            context.foregroundColor = UIColor(color)
        }
    }
    @ViewBuilder
    private var paintControl: some View {
        
        Slider(value: $thickness, in: 1...20) {
            Text("Thickness")
        }.frame(maxWidth: 200)
            .onChange(of: thickness) { newThickness in
                currentLine.lineWidth = newThickness
            }
        
        //                         ColorPickerView(selectedColor: $currentLine.color)
        ColorPicker(selection: $currentLine.color, supportsOpacity: false) {
        } //nasconde il "frame" del label 
        .labelsHidden()
        .onChange(of: currentLine.color) { newColor in
            print(newColor)
            currentLine.color = newColor
        }
    }
    
}
    

//dismiss della keyboard con ui
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
