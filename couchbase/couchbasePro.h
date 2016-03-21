//
//  couchbasePro.h
//  couchbase
//
//  Created by 刘璞峰 on 16/3/21.
//  Copyright © 2016年 patient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@protocol couchbasePro <NSObject>

-(void)CreateDoga:(NSString *)str callbackyes:(void(^)(NSString *,CBLDatabase *))couch;
-(void)addAttachment:(CBLDatabase *)datebase str:(NSString *)title documentId:(NSString *) documentId callback:(void(^)(BOOL))back;
- (void) deleteDocument:(CBLDatabase*) database documentId:(NSString*) documentId;
- (void) updateDocument:(CBLDatabase *) database documentId:(NSString *) documentId;
@end
