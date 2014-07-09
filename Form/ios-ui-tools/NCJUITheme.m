//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import "NCJUITheme.h"


@implementation NCJUITheme {

}
- (instancetype)init {
    self = [super init];
    if( self ) {
        self.name = @"NCJ";

        UIColor *darkColor = [UIColor colorWithRed:0.278 green:0.392 blue:0.184 alpha:1.000];
        UIColor *lightColor = [UIColor colorWithRed:0.451 green:0.584 blue:0.345 alpha:1.000];

        self.tintColor = darkColor;

        self.barTintColor = lightColor;
        self.navigationBarTextColor = [UIColor whiteColor];

        self.textFieldColor = [UIColor blackColor];

        self.labelColor = [UIColor blackColor];
        self.labelShadowColor = darkColor;

        self.statusBarStyle = UIStatusBarStyleDefault;

        self.cellBackgroundViewColor = lightColor;
        self.cellBackgroundViewErrorColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:0.700];
        self.cellBackgroundTransparency = 0.6f;

        self.tableHeaderBackgroundTransparency = 0.5f;
        self.tableHeaderBackgroundColor = lightColor;
    }
    return self;
}

- (BOOL)isEqualToTheme:(NCJUITheme *)other {
    return [other.name isEqualToString:_name];
}

@end