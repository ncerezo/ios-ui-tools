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