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

#import <Foundation/Foundation.h>


@interface NCJUITheme : NSObject

@property (strong, nonatomic) NSString          *name;
@property (strong, nonatomic) UIColor           *tintColor;

@property (strong, nonatomic) UIColor           *barTintColor;
@property (strong, nonatomic) UIColor           *navigationBarTextColor;

@property (strong, nonatomic) UIColor           *cellBackgroundViewColor;
@property (strong, nonatomic) UIColor           *cellBackgroundViewErrorColor;
@property (assign, nonatomic) CGFloat           cellBackgroundTransparency;

@property (strong, nonatomic) UIColor           *tableHeaderBackgroundColor;
@property (assign, nonatomic) CGFloat           tableHeaderBackgroundTransparency;

@property (strong, nonatomic) UIColor           *textFieldColor;

@property (strong, nonatomic) UIColor           *labelColor;
@property (strong, nonatomic) UIColor           *labelShadowColor;

@property (assign, nonatomic) UIStatusBarStyle  statusBarStyle;

- (instancetype)init;

- (BOOL)isEqualToTheme:(NCJUITheme *)theme;

@end