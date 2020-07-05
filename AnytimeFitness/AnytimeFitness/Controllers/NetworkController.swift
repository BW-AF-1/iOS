//
//  NetworkController.swift
//  AnytimeFitness
//
//  Created by Morgan Smith on 6/28/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation
import CoreData

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class NetworkController {
    typealias ClassCompletionHandler = (Result<Bool, NetworkError>) -> Void
    typealias CompletionHandler = (Error?) -> Void

    private let baseURL = URL(string: "https://buildweeknode.herokuapp.com/api/")
    static let sharedNetworkController = NetworkController()
    var token: Token?
    var allInstructors: [InstructorRepresentation] = []
    var allClients: [ClientRepresentation] = []
    var allClasses: [ClassRepresentation] = []
    var allCDInstructors: [Instructor] = []
    var allCDClients: [Client] = []

    var currentInstructor: InstructorRepresentation? {
        didSet{
            print("this is the network controller current instructor: \(String(describing: currentInstructor))")
        }
    }

    var currentClient: ClientRepresentation? {
        didSet{
            print("this is the network controller current client: \(String(describing: currentClient))")
        }
    }

    var currentCDInstructor: Instructor? {
        didSet{
            print("this is the network controller current core data instructor: \(String(describing: currentCDInstructor))")
        }
    }

    var currentCDClient: Client? {
        didSet{
            print("this is the network controller current core data client: \(String(describing: currentCDClient))")
        }
    }

    init() {
        fetchAllInstructors()
        fetchAllClients()
        fetchCDClient()
        fetchCDInstructor()
        fetchAllClasses()
    }

    //Client Register/login

    func registerClient(with client: ClientRepresentation, completion: @escaping CompletionHandler = { _ in }) {

        guard let registerURL = baseURL?.appendingPathComponent("clients/register") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: registerURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()

        do {
            let jsonData = try jsonEncoder.encode(client)
            request.httpBody = jsonData
        } catch {
            print("Error encoding client object: \(error)")
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            if let error = error { completion(error); return}
            guard let data = data else { completion(NSError()); return}

            let decoder = JSONDecoder()
            do {
                let currentClient = try decoder.decode(ClientRepresentation.self, from: data)
                self.createRegisteredClient(with: currentClient)
            } catch {
                print("Error decoding registered client: \(error)")
                completion(error)
                return
            }
            self.fetchAllClients()
            completion(nil)
        }.resume()
    }

    func loginClient(with client: ClientRepresentation, completion: @escaping CompletionHandler = { _ in }) {
        guard let requestURL = baseURL?.appendingPathComponent("clients/login") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()

        do {
            let jsonData = try jsonEncoder.encode(client)
            request.httpBody = jsonData
        } catch {
            print("Error encoding client object: \(error)")
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }

            if let error = error { completion(error); return}
            guard let data = data else { completion(NSError()); return}

            let decoder = JSONDecoder()

            do {
                self.token = try decoder.decode(Token.self, from: data)
                print(String(describing: self.token))
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            self.fetchAllClients()
            let filteredClient = self.allClients.filter({$0.email.contains(find: client.email)})
            let clientAuth: ClientRepresentation = filteredClient[0]
            self.fetchClientID(with: clientAuth)
            completion(nil)
        }.resume()
    }

    //Instructor Register/login

    func registerInstructor(with instructor: InstructorRepresentation, completion: @escaping CompletionHandler = { _ in }) {

        guard let registerURL = baseURL?.appendingPathComponent("instructors/register") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: registerURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()

        do {
            let jsonData = try jsonEncoder.encode(instructor)
            request.httpBody = jsonData
        } catch {
            print("Error encoding instructor object: \(error)")
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            if let error = error { completion(error); return}
            guard let data = data else { completion(NSError()); return}

            let decoder = JSONDecoder()
            do {
                let currentInstructor = try decoder.decode(InstructorRepresentation.self, from: data)
                self.createRegisteredInstructor(with: currentInstructor)
            } catch {
                print("Error decoding registered client: \(error)")
                completion(error)
                return
            }
            self.fetchAllInstructors()
            completion(nil)
        }.resume()
    }

    func loginInstructor(with instructor: InstructorRepresentation, completion: @escaping CompletionHandler = { _ in }) {

        guard let requestURL = baseURL?.appendingPathComponent("instructors/login") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()

        do {
            let jsonData = try jsonEncoder.encode(instructor)
            request.httpBody = jsonData
        } catch {
            print("Error encoding instructor object: \(error)")
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }

            if let error = error { completion(error); return}
            guard let data = data else { completion(NSError()); return}

            let decoder = JSONDecoder()

            do {
                self.token = try decoder.decode(Token.self, from: data)
                print(String(describing: self.token))
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }

            self.fetchAllInstructors()
            let filteredInstructor = self.allInstructors.filter({$0.email.contains(find: instructor.email)})
            let instructorAuth: InstructorRepresentation = filteredInstructor[0]
            self.fetchInstructorID(with: instructorAuth)
            completion(nil)
        }.resume()
    }


    //Instructor Create Class

    func createClass(newClass: NewClass, completion: @escaping ClassCompletionHandler = { _ in }) {

        guard let token = token, let id = newClass.classRepresentation?.instructorID, let createURL = baseURL?.appendingPathComponent("instructors/\(id)/classes") else { return }

        var request = URLRequest(url: createURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token.token, forHTTPHeaderField: "Authorization")

        let jsonEncoder = JSONEncoder()

               do {
                guard let representation = newClass.classRepresentation else { return }
                let jsonData = try jsonEncoder.encode(representation)
                   request.httpBody = jsonData
               } catch {
                   print("Error encoding class object: \(error)")
                completion(.failure(.noDecode))
                   return
               }

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("Error fetching current class: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.otherError))
                }
                return
            }
            completion(.success(true))
        }.resume()
    }
    
    func updateClass(for newClass: NewClass, completion: @escaping CompletionHandler = { _ in }) {
        guard let id = newClass.classRepresentation?.classID, let token = token, let updateURL = baseURL?.appendingPathComponent("classes/\(id)") else { return }

        var request = URLRequest(url: updateURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue(token.token, forHTTPHeaderField: "Authorization")

        let jsonEncoder = JSONEncoder()

        do {
            guard let representation = newClass.classRepresentation else {
                return
            }
            let jsonData = try jsonEncoder.encode(representation)
            request.httpBody = jsonData
        } catch {
            print("Error encoding edited class: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }

            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }

    func deleteClass(for newClass: NewClass, completion: @escaping CompletionHandler = { _ in }) {
        guard let id = newClass.classRepresentation?.classID, let token = token, let deleteURL = baseURL?.appendingPathComponent("classes/\(id)") else { return }

        var request = URLRequest(url: deleteURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue(token.token, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { _, _, error in
            print("Deleted class with ID: \(id)")
            completion(error)
        }.resume()
    }

    func fetchAllInstructors(completion: @escaping ClassCompletionHandler = { _ in }) {

        guard let requestURL = baseURL?.appendingPathComponent("instructors") else { return }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error fetching all instructors: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.otherError))
                }
                return
            }

            guard let data = data else {
                print("No data returned by data instructors")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
                return
            }

            let decoder = JSONDecoder()

            do {
                let allInstructors = try decoder.decode([InstructorRepresentation].self, from: data)
                self.allInstructors = allInstructors
                print("successfully decoded allInstructors from networkController \(allInstructors)")
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } catch {
                print("Error decoding instructor representations: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.noDecode))
                }
                return
            }
        }.resume()
    }

    func fetchAllClasses(completion: @escaping ClassCompletionHandler = { _ in }) {

        guard let requestURL = baseURL?.appendingPathComponent("classes") else { return }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error fetching all classes: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.otherError))
                }
                return
            }

            guard let data = data else {
                print("No data returned by data all classes")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
                return
            }

            let decoder = JSONDecoder()

            do {
                let allClasses = try decoder.decode([ClassRepresentation].self, from: data)
                self.allClasses = allClasses
                print("successfully decoded allClasses from networkController \(allClasses)")
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } catch {
                print("Error decoding class representations: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.noDecode))
                }
                return
            }
        }.resume()
    }

    func fetchInstructorID(with instructor: InstructorRepresentation, completion: @escaping ClassCompletionHandler = { _ in }) {

        guard let token = token, let id = instructor.instructorID, let createURL = baseURL?.appendingPathComponent("instructors/\(id)") else { return }

        var request = URLRequest(url: createURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token.token, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching current instructor ID: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.otherError))
                }
                return
            }

            guard let data = data else {
                print("No data returned by data current instructor ID")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
                return
            }

            let decoder = JSONDecoder()

            do {
                let allInstructors = try decoder.decode(InstructorRepresentation.self, from: data)
                self.currentInstructor = allInstructors
                self.fetchInstructor(with: allInstructors)
                print("successfully decoded current instructor from networkController \(allInstructors)")
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } catch {
                print("Error decoding current instructor representations: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.noDecode))
                }
                return
            }
        }.resume()
    }

    func fetchAllClients(completion: @escaping ClassCompletionHandler = { _ in }) {

        guard let requestURL = baseURL?.appendingPathComponent("clients") else { return }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error fetching all clients: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.otherError))
                }
                return
            }

            guard let data = data else {
                print("No data returned by data instructors")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
                return
            }

            let decoder = JSONDecoder()

            do {
                let allClients = try decoder.decode([ClientRepresentation].self, from: data)
                self.allClients = allClients
                print("successfully decoded allClients from networkController \(allClients)")
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } catch {
                print("Error decoding client representations: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.noDecode))
                }
                return
            }
        }.resume()
    }

    func fetchClientID(with client: ClientRepresentation, completion: @escaping ClassCompletionHandler = { _ in }) {

        guard let token = token, let id = client.clientID, let createURL = baseURL?.appendingPathComponent("clients/\(id)") else { return }

        var request = URLRequest(url: createURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token.token, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching current cient ID: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.otherError))
                }
                return
            }

            guard let data = data else {
                print("No data returned by data current client ID")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
                return
            }

            let decoder = JSONDecoder()

            do {
                let thisClient = try decoder.decode(ClientRepresentation.self, from: data)
                self.currentClient = thisClient
                self.fetchClient(with: thisClient)
                print("successfully decoded current client from networkController \(thisClient)")
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } catch {
                print("Error decoding current client representations: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.noDecode))
                }
                return
            }
        }.resume()
    }

    private func createRegisteredClient(with representation: ClientRepresentation) {
        Client(clientRepresentation: representation)
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("error saving registered client to core data)")
        }
    }

    private func createRegisteredInstructor(with representation: InstructorRepresentation) {
        Instructor(instructorRepresentation: representation)
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("error saving registered instructor to core data)")
        }
    }

    private func addClassID(with newClass: NewClass, representation: ClassRepresentation) {
        guard let newID = representation.classID else { return }
        newClass.classID = Int16(newID)
        do {
            try CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        } catch {
            print("error saving new class ID to core data)")
        }
    }

    private func fetchClient(with representation: ClientRepresentation) {
        let fetchRequestClient: [Client]? = {
            let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
            let moc = CoreDataStack.shared.mainContext
            var fetchedClient: [Client] = []
            do {
                fetchedClient = try moc.fetch(fetchRequest)
            } catch {
                NSLog("error fetching Client objects")
            }
            return fetchedClient
        }()

        if let results = fetchRequestClient {
            let filteredClient = results.filter({$0.email.contains(find: representation.email)})
            let filtered = filteredClient[0]
            filtered.clientID = Int16(representation.clientID!)
            self.currentCDClient = filtered
        } else {
            print("error matching server client to core data")
        }
    }

    private func fetchInstructor(with representation: InstructorRepresentation) {
        let fetchRequestInstructor: [Instructor]? = {
            let fetchRequest: NSFetchRequest<Instructor> = Instructor.fetchRequest()
            let moc = CoreDataStack.shared.mainContext
            var fetchedInstructor: [Instructor] = []
            do {
                fetchedInstructor = try moc.fetch(fetchRequest)
            } catch {
                NSLog("error fetching Instructor objects")
            }
            return fetchedInstructor
        }()

        if let results = fetchRequestInstructor {
            let filteredInstructors = results.filter({$0.email.contains(find: representation.email)})
            let filtered = filteredInstructors[0]
            filtered.instructorID = Int16(representation.instructorID!)
            self.currentCDInstructor = filtered
        } else {
            print("error matching server instructor to core data")
        }
    }

    func fetchCDInstructor() {
        let fetchRequestInstructor: [Instructor]? = {
            let fetchRequest: NSFetchRequest<Instructor> = Instructor.fetchRequest()
            let moc = CoreDataStack.shared.mainContext
            var fetchedInstructor: [Instructor] = []
            do {
                fetchedInstructor = try moc.fetch(fetchRequest)
            } catch {
                NSLog("error fetching Instructor objects")
            }
            return fetchedInstructor
        }()
        if let fetch = fetchRequestInstructor {
            allCDInstructors = fetch
        }
    }

    func fetchCDClient() {
        let fetchRequestClient: [Client]? = {
            let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
            let moc = CoreDataStack.shared.mainContext
            var fetchedClient: [Client] = []
            do {
                fetchedClient = try moc.fetch(fetchRequest)
            } catch {
                NSLog("error fetching Client objects")
            }
            return fetchedClient
        }()
        if let fetch = fetchRequestClient {
            allCDClients = fetch
        }
    }

}
