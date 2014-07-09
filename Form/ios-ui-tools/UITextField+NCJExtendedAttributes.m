//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


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