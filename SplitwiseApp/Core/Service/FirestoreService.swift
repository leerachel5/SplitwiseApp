//
//  FirestoreService.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 9/8/24.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct FirestoreService {
    // Singleton FirebaseService instance
    static let shared = FirestoreService()
    private(set) var db: Firestore
    
    private init() {
        db = Firestore.firestore()
    }
    
    func setData(_ data: Dictionary<String, Any>, collectionPath: String, document: String) async throws {
        try await db.collection(collectionPath).document(document).setData(data)
    }
    
    func setData<T: Encodable>(from object: T, collectionPath: String, document: String) async throws {
        let objectDict = object.toDictionary()
        try await db.collection(collectionPath).document(document).setData(objectDict)
    }
    
    func getDocumentAndDecode<T: Decodable>(to type: T.Type, collectionPath: String, document: String) async throws -> T? {
        let docRef = db.collection(collectionPath).document(document)
        let document = try await docRef.getDocument()
        if document.exists, let dataDescription = document.data() {
            let decodedObject = T.from(dictionary: dataDescription)
            return decodedObject
        }
        return nil
    }
    
    func getDocumentsAndDecode<T: Decodable>(to type: T.Type, collectionPath: String) async throws -> [T] {
        let querySnapshot = try await db.collection(collectionPath).getDocuments()
        var decodedObjects: [T] = []
        for document in querySnapshot.documents {
            if let decodedObject = T.from(dictionary: document.data()) {
                decodedObjects.append(decodedObject)
            }
        }
        return decodedObjects
    }
    
    func deleteDocument(collectionPath: String, document: String) async throws {
        try await db.collection(collectionPath).document(document).delete()
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                } else {
                    continuation.resume(throwing: NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
                }
            }
        }
    }
}
