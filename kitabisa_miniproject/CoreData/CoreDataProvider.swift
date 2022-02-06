//
//  CoreDataProvider.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import CoreData

class CoreDataProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "kitabisa_miniproject")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getFavoriteMovies( completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
            do {
                let results = try taskContext.fetch(fetchRequest)
                
                let movies = results.map {
                    
                    return MovieModel(
                        id: $0.value(forKey: "movieId") as? Int ?? 0 ,
                        releaseDate: $0.value(forKey: "releaseDate") as? String ?? "",
                        title: $0.value(forKey: "title") as? String ?? "",
                        overview: $0.value(forKey: "overview") as? String ?? "",
                        posterUrl: $0.value(forKey: "posterUrl") as? String ?? ""
                    )
                    
                }
                completion(.success(movies))
            } catch let error as NSError {
                completion(.failure(error))
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func addMovie(_ movie: MovieModel, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: taskContext) {
                let bookmark = NSManagedObject(entity: entity, insertInto: taskContext)
                bookmark.setValue(movie.id, forKey: "movieId")
                bookmark.setValue(movie.releaseDate, forKey: "releaseDate")
                bookmark.setValue(movie.title, forKey: "title")
                bookmark.setValue(movie.overview, forKey: "overview")
                bookmark.setValue(movie.posterUrl, forKey: "posterUrl")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func deleteMovie(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "movieId == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
               batchDeleteResult.result != nil {
                completion()
            }
        }
    }
    
    func isFavoritedMovie(_ id: Int,
                          completion: @escaping(_ isFavorite: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "movieId == \(id)")
            do {
                if (try taskContext.fetch(fetchRequest).first) != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
