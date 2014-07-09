//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSUserDefaults (NCJAdditions)

@property (assign, getter=ncj_themeName, setter=setNcj_themeName:) NSString *ncj_themeName;

- (NSString *)ncj_themeName;
- (void)setNcj_themeName:(NSString *)themeName;

@end