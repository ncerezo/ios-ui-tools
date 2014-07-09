//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import "NCJAppSingleton.h"

#import "NCJUITheme.h"
#import "NSUserDefaults+NCJAdditions.h"

@implementation NCJAppSingleton {

}

+ (instancetype)sharedInstance {
    static NCJAppSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NCJAppSingleton alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (instancetype)init {

    self = [super init];
    if( self ) {

    }

    return self;
}

- (NCJUITheme *)currentTheme {
    if( _currentTheme == nil ) {
        NSString *themeName = [NSUserDefaults standardUserDefaults].ncj_themeName;
        _currentTheme = [self loadThemeWithName:themeName];
        if( _currentTheme == nil ) {
            if( _defaultTheme ) {
                _currentTheme = _defaultTheme;
            }
            else {
                _currentTheme = [[NCJUITheme alloc] init];
            }
            [NSUserDefaults standardUserDefaults].ncj_themeName = _currentTheme.name;
        }
    }
    return _currentTheme;
}


- (NCJUITheme *)loadThemeWithName:(NSString *)name {
    Class clazz = NSClassFromString( [NSString stringWithFormat:@"%@UITheme", name] );
    if( clazz ) {
        id theme = [clazz new];
        if( [theme isKindOfClass:[NCJUITheme class]] ) {
            return theme;
        }
    }
    return nil;
}

- (void)customizeAppearance:(UIWindow *)window {
    NCJUITheme *theme = self.currentTheme;

    window.tintColor = theme.tintColor;

    [UINavigationBar appearance].barTintColor = theme.barTintColor;
    [UINavigationBar appearance].tintColor = theme.navigationBarTextColor;
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName: theme.navigationBarTextColor };

    [UIApplication sharedApplication].statusBarStyle = theme.statusBarStyle;
    [UIView appearance].tintColor = theme.tintColor;
    [[UIApplication sharedApplication] keyWindow].tintColor = theme.tintColor;

    [UILabel appearance].textColor = theme.labelColor;
//    [UILabel appearance].shadowColor = theme.labelShadowColor;

    [UITextField appearance].textColor = theme.textFieldColor;
}

@end