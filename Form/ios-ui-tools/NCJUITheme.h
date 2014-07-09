//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


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