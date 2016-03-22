//
//  couchDemo.m
//  couchbase
//
//  Created by 刘璞峰 on 16/3/21.
//  Copyright © 2016年 patient. All rights reserved.
//

#import "couchDemo.h"
#import <CouchbaseLite/CouchbaseLite.h>

@interface couchDemo ()
@property (nonatomic, strong) CBLDatabase *database;
@property (nonatomic, strong) CBLManager *manager;
@end

@implementation couchDemo
//类 interface
//RCT_EXPORT_MODULE(CouchBase);

//Create
-(void)CreateDoga:(NSString *)str callbackyes:(void(^)(NSString *,CBLDatabase *))couch
{
    NSError *error;
    NSDictionary *message = @{@"date":@"2016.3.21"};
    CBLDocument *doc = [self.database createDocument];
    NSString *docID = doc.documentID;
    //update or add 设置网关等
    CBLRevision *newRevision = [doc putProperties:message error:&error];
    if (newRevision) {
        NSLog(@"Document created and written to database, ID = %@", docID);
    }
    couch(docID,self.database);
}
//add
-(void)addAttachment:(CBLDatabase *)datebase str:(NSString *)title documentId:(NSString *) documentId callback:(void(^)(BOOL))back
{
    NSError *error;
    CBLDocument *document = [datebase documentWithID:documentId];
    CBLUnsavedRevision *unsavedRev = [document.currentRevision createRevision];
    [unsavedRev setObject:@{title:title} forKeyedSubscript:title];
    CBLSavedRevision *newRev = [unsavedRev save: &error];
    NSLog(@"The new revision of the document contains: %@", newRev.properties);
    (error) ? (back(false)) : (back(true));
}
//update
- (void) updateDocument:(CBLDatabase *) database documentId:(NSString *) documentId {
    // 1. Retrieve the document from the database
    CBLDocument *getDocument = [database documentWithID: documentId];
    // 2. Make a mutable copy of the properties from the document we just retrieved
    NSMutableDictionary *docContent = [getDocument.properties mutableCopy];
    // 3. Modify the document properties
    docContent[@"date"] = @"date has been updated";
    // 4. Save the Document revision to the database
    NSError *error;
    CBLSavedRevision *newRev = [getDocument putProperties:docContent error:&error];
    if (!newRev) {
        NSLog(@"Cannot update document. Error message: %@", error.localizedDescription);
        NSLog(@"%@",error.userInfo);
    }
    // 5. Display the new revision of the document
    NSLog(@"The new revision of the document contains: %@", newRev.properties);
}
//delete
- (void)deleteDocument:(CBLDatabase*) database documentId:(NSString*) documentId {
    CBLDocument* document = [database documentWithID:documentId];
    NSError* error;
    [document deleteDocument:&error];
    if (!error) {
        NSLog(@"Deleted document, deletion status is %d", [document isDeleted]);
    }
    NSLog(@"%@",error);
}

//query
-(void)query:(CBLDatabase*) database documentId:(NSString*) documentId
{
    CBLDocument *document = [database documentWithID:documentId];
    
    NSLog(@"%@",document.properties);
}

- (id)init {
    self = [super init];
    if (self) {
        NSError *error;
        self.manager = [CBLManager sharedInstance];
        if (!self.manager) {
            NSLog(@"Cannot create shared instance of CBLManager");
            return nil;
        }
        self.database = [self.manager databaseNamed:@"couchbaseevents" error:&error];
        if (!self.database) {
            NSLog(@"Cannot create database. Error message: %@", error.localizedDescription);
            return nil;
        }
    }
    return self;
}






@end
