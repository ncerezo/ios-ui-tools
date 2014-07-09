//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import <Foundation/Foundation.h>

@class NCJUITheme;

@interface NCJAppSingleton : NSObject

@property (strong, nonatomic)   NCJUITheme *defaultTheme;
@property (strong, nonatomic)   NCJUITheme *currentTheme;

+ (instancetype) sharedInstance;

- (instancetype) init;

- (NCJUITheme *)loadThemeWithName:(NSString *)name;

- (void)customizeAppearance:(UIWindow *)window;

@end