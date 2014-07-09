//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import "NCJMainUITheme.h"
#import "UIColor+NCJColorWithARGB.h"


@implementation NCJMainUITheme {

}

- (instancetype)init {
    self = [super init];
    if( self ) {
        self.name = @"NCJMain";

        UIColor *darkColor = [UIColor ncj_colorWithARGB:0xFF534c47];
        UIColor *lightColor = [UIColor ncj_colorWithARGB:0xFFb3aaa4];

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

@end