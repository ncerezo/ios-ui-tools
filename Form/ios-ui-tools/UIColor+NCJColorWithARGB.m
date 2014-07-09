//
// Created by Narciso Cerezo Jiménez on 09/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import "UIColor+NCJColorWithARGB.h"


@implementation UIColor (NCJColorWithARGB)

+ (UIColor *)ncj_colorWithARGB:(NSUInteger)argb {
    CGFloat red = ((argb & 0xFF0000) >> 16);
    CGFloat green = ((argb & 0xFF00) >> 8);
    CGFloat blue = (argb & 0xFF);
    CGFloat alpha = ((argb & 0xFF000000) >> 24);
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
}

@end