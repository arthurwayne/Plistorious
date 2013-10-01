//
//  BAVPlistNode.h
//  Plistorious
//
//  Created by Bavarious on 01/10/2013.
//  Copyright (c) 2013 No Organisation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAVPlistNode : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSObject *value;
@property (nonatomic, copy) NSArray *children;
@property (nonatomic, assign, getter = isCollection) bool collection;

+ (instancetype)plistNodeFromObject:(id)object key:(NSString *)key;
@end
