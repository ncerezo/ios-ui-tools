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

#import <objc/runtime.h>
#import "UITextField+NCJExtendedAttributes.h"

static void *NCJTextFieldNameKey;
static void *NCJTextFieldOriginalValueKey;
static void *NCJTextFieldCellIndexPathKey;

@implementation UITextField (NCJExtendedAttributes)

- (NSString *)ncj_fieldName {
    return objc_getAssociatedObject( self, &NCJTextFieldNameKey );
}

- (void)setNcj_fieldName:(NSString *)fieldName {
    objc_setAssociatedObject( self, &NCJTextFieldNameKey, fieldName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObject *)ncj_originalValue {
    return objc_getAssociatedObject( self, &NCJTextFieldOriginalValueKey );
}

- (void)setNcj_originalValue:(NSObject *)originalValue {
    objc_setAssociatedObject( self, &NCJTextFieldOriginalValueKey, originalValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)ncj_cellIndexPath {
    return objc_getAssociatedObject( self, &NCJTextFieldCellIndexPathKey );
}

- (void)setNcj_cellIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject( self, &NCJTextFieldCellIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end