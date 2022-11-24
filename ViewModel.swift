//
//  ViewModel.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 19/11/22.
//


import Foundation
import CoreData
import UIKit
import SwiftUI

//# La prima cosa da fare è creare il nostro view model come ObservableObject, in modo che possa essere osservato dalla nostra view:

class ViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntity: [NoteEntity] = []
    @Published var favoriteNotes: [NoteEntity] = []
    @Published var selectNote: NoteEntity?
    
    init () {
        container = NSPersistentContainer(name: "NotesDataContainer") // per dirgli a quale database accedere
        container.loadPersistentStores /*per caricare i dati*/ { description, error in
            if let error = error {
                print("Error loading. \(error)")
            }
            else {
                print("Core data loaded successfully") /*if error != null ti restituisce l'errore (error è ? , quindi per estrarre  il valore da questa variabile bisogna fare unwrap con if let o guard)*/
                //self.newNote = NoteEntity(context: self.container.viewContext)
            }
        }
        fetchNotes()
        fetchFavorite()
    }
    func fetchNotes() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        //        let filter = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        //        request.predicate = filter
        do {
            let savedEntity =  try container.viewContext.fetch(request)
            self.savedEntity = savedEntity.reversed() //ordinare per più recente
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    // # In pratica stiamo dicendo al nostro codice: crea la richiesta di recupero, prova a recuperare i dati dal container salvandoli in savedEntity, se non riesci trova l'errore e plottalo.
    
    func addNote(text: NSAttributedString, lines: [Line]) {
        let newNote = NoteEntity(context: container.viewContext) //per creare una nuova entity di noteEntity
     //   let imageData = image.jpegData(compressionQuality: 1.0)
        //        newNote.name = "title"
        //        newNote.data = Date()
        newNote.isFavorite = false
        newNote.text = text
     //   newNote.image = imageData
        saveLines(lines: lines, entity: newNote)
        //saveData()
        
    }
    func saveData() {
        do {
            try container.viewContext.save() //salva il context
            fetchNotes()
            fetchFavorite()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    // # Quindi gli stiamo dicendo aggiungi l'elemento con queste proprietà e poi salvalo.   Ma i nostri dati sulla view sono sempre collegati alla variabile @Published savedEntity, quindi ogni volta che aggiungiamo un elemento e facciamo click su save dobbiamo aggiornare nuovamente questa variabile. Il modo più semplice per farlo è chiamare nuovamente la funzione fetch(), perchè questa crea la fetch request. Quindi la fetch va a cercare nuovamente i dati all'interno del database e li aggiorna sulla variabile, comprese le nuove aggiunte.
    
    func deleteNote(indexSet: IndexSet) {
        guard  let index = indexSet.first else {return} //.first per tirare fuori un elemento compatibile con l'array // l'indexSet è riferito all'index della lista
        let entity = savedEntity[index]
        container.viewContext.delete(entity)
        saveData()
    }
    func deleteGridNote(entity: NoteEntity) {
        if let index = savedEntity.firstIndex(where: {
            $0 == entity
        }) {
            let entity = savedEntity[index]
            container.viewContext.delete(entity)
            saveData()
        }
    }
    func addFavorite(entity: NoteEntity) {
        if let index = savedEntity.firstIndex(where: {
            $0 == entity
        }) {
            entity.isFavorite = !savedEntity[index].isFavorite //per invertire il valore di favorite
            saveData()
        }
        
    }
    func fetchFavorite() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        let filter = NSPredicate(format: "isFavorite == %@", NSNumber(value: true)) // %@ significa sostituisci con il valore che ti do
        request.predicate = filter
        do {
            favoriteNotes =  try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func updateNote(entity: NoteEntity, text: NSAttributedString) {
        entity.text = text    //gli devi passare l'entity e l'attributo che vuoi andare a salvare
        saveData()
    }
    
 // Tentativo 1
//    struct Line {
//        var points = [CGPoint]()
//        var color: Color = .red
//        var lineWidth: Double = 1.0
//    }
    
// Line è un oggetto che contiene un array di CGpoint, color e linwWidth. Per salvare l'oggetto dobbiamo scomporre queste tre proprietà, quindi:
// Color si può scomporre con l'rgba
// lineWidth è apposto perchè è un double
// points va scomposto in x, y che possiamo segnare come double
// quindi si crea la relationship tra: lineWidht e thickness, note e lines, line e points (un point è composto da x e y)
    
    func fetchDeleteLines(entity: NoteEntity) {
        //var lineEntity: [LineEntity] = []
        let request = NSFetchRequest<LineEntity>(entityName: "LineEntity")
        let filter = NSPredicate(format: "note == %@", entity) //serve per filtrare le linee di una precisa note entity
        request.predicate = filter
        do {
            let lines = try container.viewContext.fetch(request)
            for line in lines {
            container.viewContext.delete(line)
               } //non funziona???
            } catch let error {
                print("Error delete lines. \(error)")
        }
        saveData()
    }
    
    
// https://tiannahenrylewis.medium.com/a-simple-approach-to-saving-color-in-coredata-with-swiftui-55ab4de1f828
// rgba (a sta per alpha) // qui scomponiamo i colori con questo schema:
    
//    extension Color
//        var components: (r: Double, g: Double, b: Double, a: Double)
//            var r: CGFloat = 0
//            var g: CGFloat = 0
//            var b: CGFloat = 0
//            var a: CGFloat = 0
//            guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else { return (0,0,0,0)
//            return (Double(r), Double(g), Double(b), Double(a))
// In questa estensione già ci ritorna dei double sotto la variabile components (color viene dalla struttura di line)

    func saveLines(lines: [Line], entity: NoteEntity) {
        fetchDeleteLines(entity: entity)
        var indexLines: Int16 = 0
        for line in lines {
            let red = line.color.components.r
            let green = line.color.components.g
            let blue = line.color.components.b
            let opacity = line.color.components.a
            
            let lineEntity = LineEntity(context: container.viewContext)
            lineEntity.red = red //ora gli diciamo che il valore che abbiamo salvato nel database assume il valore di queste costanti
            lineEntity.green = green
            lineEntity.blue = blue
            lineEntity.opacity = opacity
            lineEntity.thickness = line.lineWidth
            lineEntity.indexLines = indexLines
            indexLines += 1 //per sovrapporre le più recenti
            entity.addToLines(lineEntity) //addTo è una funzione di coredata, in questo caso serve ad aggiungere la lineEntity alla noteEntity e quindi a creare la relazione
            print("NUMBER OF POINTS SAVE: \(line.points.count)")
            
// questo per scomporre i punti, quindi:
            var index: Int16 = 0        // creiamo un indice dei punti
            for point in line.points {  //andiamo nell'oggetto line
                let x = Double(point.x) //creiamo un ciclo for per tutti i punti
                let y = Double(point.y)
                let pointEntity = LinePointEntity(context: container.viewContext)
                pointEntity.x = x // di nuovo diciamo che le variabili nel database sono uguali alle costanti create adesso
                pointEntity.y = y
                pointEntity.index = index
                index += 1    // per dare un ordine crescente all'indice
                lineEntity.addToPoints(pointEntity)
            }
        }
        saveData()
    }
    
    
    func fetchLines(entity: NoteEntity) -> [Line] { //prendi un'entità di tipo noteEntity e ritorna un array di line
        var lines: [Line] = []
        var lineEntity: [LineEntity] = []
        //crea la richiesta
        let request = NSFetchRequest<LineEntity>(entityName: "LineEntity")
        let filter = NSPredicate(format: "note == %@", entity)
        request.predicate = filter
        let sort2 = NSSortDescriptor(keyPath: \LineEntity.indexLines, ascending: true)
        request.sortDescriptors = [sort2]
        let requestPoints = NSFetchRequest<LinePointEntity>(entityName: "LinePointEntity")
        do {
            lineEntity = try container.viewContext.fetch(request)
            print("line \(lineEntity)")
            
// Salvati i dati vanno ricomposti nella forma originale. Quindi le linee in un array e i punti come array di cgpoint:
            for line in lineEntity {
                var points: [LinePointEntity] = [] //la variabile points è uguale a tutti i punti salvati nel database per quella linea
                var cgPoints: [CGPoint] = [] // questo per riconvertirli in cgpoint
                let filterPoint = NSPredicate(format: "line == %@", line)
                requestPoints.predicate = filterPoint
                let sort = NSSortDescriptor(keyPath: \LinePointEntity.index, ascending: true)
                requestPoints.sortDescriptors = [sort]
                do {
                    points = try container.viewContext.fetch(requestPoints) //qua prendiamo tutti i punti perchè creiamo la richiesta
                   
                    
                   //qua ricomponiamo i punti
                    for point in points {
                        let point = CGPoint(x: point.x, y: point.y)
                        cgPoints.append(point)
                    }
                    print("NUMBER OF POINTS FETCH \(points.count)")
                    
// Adesso che abbiamo salvato, ripreso e riconvertito tutte le proprietà di Line possiamo creare la prima linea inizializzandola
                    let line: Line = Line(points: cgPoints, color: Color(red: line.red, green: line.green, blue: line.blue, opacity: line.opacity), lineWidth: line.thickness)
                    lines.append(line) // ora diciamo di aggiungere all'array lines la linea appena creata
                    
                } catch let error {
                    print("Error fetching points. \(error)")
                }
                 
            }
        }  catch let error {
            print("Error fetching lines. \(error)")
        }
        
        return lines  // ritorna l'array 
        
        
    }
   
}

