import SwiftUI

struct LoadTxtFile: View {
    
    @Binding var result: String
    @State private var openFile = false
    @State private var fileName = "no file chosen"
    
    var body: some View {
        Button { self.openFile.toggle() } label: {
            Text("Выбрать файл")
        }
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.text], allowsMultipleSelection: false) { result in
            do {
                if let fileURL = try result.get().first {
                    guard fileURL.startAccessingSecurityScopedResource() else { return }
                    let data = try String(contentsOfFile: fileURL.path)
                    self.result = data
                } else {
                    self.fileName = "No file selected"
                    self.result = ""
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }
    
    func loadFileFromLocalPath(_ localFilePath: String) -> String? {
        return try? String(contentsOfFile: localFilePath)
    }
}

#Preview {
    LoadTxtFile(result: .constant("str"))
}
