import SwiftUI
import UniformTypeIdentifiers
import CoreData
import QuickLook

struct DossierView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: FileEntity.entity(),
        sortDescriptors: []
    ) var fileEntities: FetchedResults<FileEntity>

    @State private var showPicker: Bool = false
    @State private var selectedFile: FileEntity?
    @State private var showAlert: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Text("Add a files")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)

                    Divider().background(Color.white)

                    Text("Here you can import files in .pdf or .png format. These files will be listed below once added.")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Button(action: {
                        showPicker = true
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Import Files")
                        }
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    .padding()

                    Divider().background(Color(.systemGray6))

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(fileEntities, id: \.self) { entity in
                            if let url = URL(string: entity.path ?? ""), let uiImage = UIImage(contentsOfFile: url.path) {
                                ZStack {
                                    NavigationLink(destination: QuickLookView(url: url)) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                            .padding(5)
                                    }

                                    VStack {
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                selectedFile = entity
                                                showAlert = true
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.white)
                                            }
                                            .padding(5)
                                            .background(Color.black.opacity(0.7))
                                            .clipShape(Circle())
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Confirmation"),
                              message: Text("Are you sure you want to delete this file?"),
                              primaryButton: .destructive(Text("Delete")) {
                                if let file = selectedFile {
                                    viewContext.delete(file)
                                    PersistenceManager.shared.saveContext()
                                }
                              },
                              secondaryButton: .cancel())
                    }
                }
                .padding()
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left").foregroundColor(Color.white)
                    Text("Retour").foregroundColor(Color.white)
                }
            })
            .sheet(isPresented: $showPicker) {
                FilePickerView(completion: saveFileURLs)
            }
        }
    }

    func saveFileURLs(urls: [URL]) {
        for url in urls {
            let newFileEntity = FileEntity(context: viewContext)
            newFileEntity.path = url.absoluteString
        }
        PersistenceManager.shared.saveContext()
    }
}


struct FilePickerView: UIViewControllerRepresentable {
    var completion: (([URL]) -> Void)?
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: FilePickerView
        
        init(_ parent: FilePickerView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.completion?(urls)
        }
    }
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let types = [UTType.pdf, UTType.png]
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: types, asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

struct QuickLookView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let parent: QuickLookView

        init(parent: QuickLookView) {
            self.parent = parent
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.url as QLPreviewItem
        }
    }
}

struct DossierView_Previews: PreviewProvider {
    static var previews: some View {
        DossierView().environment(\.managedObjectContext, PersistenceManager.shared.context)
    }
}
