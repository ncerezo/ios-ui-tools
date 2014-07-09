//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import "NSObject+NCJProtocolOptionalMethod.h"


@implementation NSObject (NCJProtocolOptionalMethod)

- (void)performBlock:(void (^)(void))block ifRespondsTo:(SEL) aSelector {
    [self performBlock:block ifRespondsTo:aSelector elsePerformBlock:nil];
}

- (void)performBlock:(void (^)(void))block ifRespondsTo:(SEL) aSelector elsePerformBlock:(void (^)(void))elseBlock {
    if ([self respondsToSelector:aSelector]) {
        block();
    }
    else if( elseBlock ) {
        elseBlock();
    }
}

@end