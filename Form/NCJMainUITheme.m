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