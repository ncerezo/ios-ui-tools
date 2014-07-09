//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSObject (NCJProtocolOptionalMethod)

- (void)performBlock:(void (^)(void))block ifRespondsTo:(SEL)aSelector;

- (void)performBlock:(void (^)(void))block ifRespondsTo:(SEL)aSelector elsePerformBlock:(void (^)(void))elseBlock;

@end