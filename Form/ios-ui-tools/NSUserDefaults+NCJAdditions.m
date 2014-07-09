//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import "NSUserDefaults+NCJAdditions.h"


@implementation NSUserDefaults (NCJAdditions)

- (NSString *)ncj_themeName {
    NSString *themeName = [self stringForKey:@"themeName"];
    return themeName != nil ? themeName : @"NCJMain";
}

- (void)setNcj_themeName:(NSString *)themeName {
    [self setValue:themeName forKey:@"themeName"];
}

@end