/*
   Copyright (c) 2014 Narciso Cerezo. All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/


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