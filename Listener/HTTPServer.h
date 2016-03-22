//
//  HTTPServer.h
//  couchbase
//
//  Created by 刘璞峰 on 16/3/22.
//  Copyright © 2016年 patient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPServer : NSObject
@property (nonatomic,assign) void (^callback) (NSString *);
@end
