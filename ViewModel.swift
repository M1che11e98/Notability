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

// 1 # La prima cosa da fare è creare il nostro view model come ObservableObject, in modo che possa essere osservato dalla nostra view:

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
            self.savedEntity = savedEntity.reversed()
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    // # In pratica stiamo dicendo al nostro codice: crea la richiesta di recupero, prova a recuperare i dati dal container salvandoli in savedEntity, se non riesci trova l'errore e plottalo.
    
    func addNote(text: NSAttributedString, lines: [Line]) {
        let newNote = NoteEntity(context: container.viewContext)
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
            try container.viewContext.save()
            fetchNotes()
            fetchFavorite()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    // # Quindi gli stiamo dicendo aggiungi l'elemento con queste proprietà e poi salvalo.   Ma i nostri dati sulla view sono sempre collegati alla variabile @Published savedEntity, quindi ogni volta che aggiungiamo un elemento e facciamo click su save dobbiamo aggiornare nuovamente questa variabile. Il modo più semplice per farlo è chiamare nuovamente la funzione fetch(), perchè questa crea la fetch request. Quindi la fetch va a cercare nuovamente i dati all'interno del database e li aggiorna sulla variabile, comprese le nuove aggiunte.
    
    func deleteNote(indexSet: IndexSet) {
        guard  let index = indexSet.first else {return} //.first per tirare fuori un elemento compatibile con l'array
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
            entity.isFavorite = !savedEntity[index].isFavorite
            saveData()
        }
        
    }
    func fetchFavorite() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        let filter = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        request.predicate = filter
        do {
            favoriteNotes =  try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func updateNote(entity: NoteEntity, text: NSAttributedString) {
        entity.text = text
        saveData()
    }
    
 // Tentativo 1
    
    func fetchDeleteLines(entity: NoteEntity) {
        //var lineEntity: [LineEntity] = []
        let request = NSFetchRequest<LineEntity>(entityName: "LineEntity")
        let filter = NSPredicate(format: "note == %@", entity)
        request.predicate = filter
        do {
            let lines = try container.viewContext.fetch(request)
            for line in lines {
            container.viewContext.delete(line)
               }
            } catch let error {
                print("Error delete lines. \(error)")
        }
        saveData()
    }
    
    
     // https://tiannahenrylewis.medium.com/a-simple-approach-to-saving-color-in-coredata-with-swiftui-55ab4de1f828
    // rgba (a sta per alpha)
    func saveLines(lines: [Line], entity: NoteEntity) {
        fetchDeleteLines(entity: entity)
        var indexLines: Int16 = 0
        for line in lines {
            let red = line.color.components.r
            let green = line.color.components.g
            let blue = line.color.components.b
            let opacity = line.color.components.a
            let lineEntity = LineEntity(context: container.viewContext)
            lineEntity.red = red
            lineEntity.green = green
            lineEntity.blue = blue
            lineEntity.opacity = opacity
            lineEntity.thickness = line.lineWidth
            lineEntity.indexLines = indexLines
            indexLines += 1
            entity.addToLines(lineEntity)
            print("NUMBER OF POINTS SAVE: \(line.points.count)")
            var index: Int16 = 0
            for point in line.points {
                let x = Double(point.x)
                let y = Double(point.y)
                let pointEntity = LinePointEntity(context: container.viewContext)
                pointEntity.x = x
                pointEntity.y = y
                pointEntity.index = index
                index += 1
                lineEntity.addToPoints(pointEntity)
            }
        }
        saveData()
    }
    
    
    func fetchLines(entity: NoteEntity) -> [Line] {
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
            //punti
            for line in lineEntity {
                var points: [LinePointEntity] = []
                var cgPoints: [CGPoint] = []
                let filterPoint = NSPredicate(format: "line == %@", line)
                requestPoints.predicate = filterPoint
                let sort = NSSortDescriptor(keyPath: \LinePointEntity.index, ascending: true)
                requestPoints.sortDescriptors = [sort]
                do {
                    points = try container.viewContext.fetch(requestPoints)
                    for point in points {
                        let point = CGPoint(x: point.x, y: point.y)
                        cgPoints.append(point)
                    }
                    print("NUMBER OF POINTS FETCH \(points.count)")
                    let line: Line = Line(points: cgPoints, color: Color(red: line.red, green: line.green, blue: line.blue, opacity: line.opacity), lineWidth: line.thickness)
                    lines.append(line)
                    
                } catch let error {
                    print("Error fetching points. \(error)")
                }
                 
            }
        }  catch let error {
            print("Error fetching lines. \(error)")
        }
        
        return lines
        
        
    }
   
}

