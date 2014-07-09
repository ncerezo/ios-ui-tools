//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface UITextField (NCJExtendedAttributes)

-(NSString *)ncj_fieldName;
-(void)setNcj_fieldName:(NSString *)fieldName;

-(NSObject *)ncj_originalValue;
-(void)setNcj_originalValue:(NSObject *)originalValue;

-(NSIndexPath *)ncj_cellIndexPath;
-(void)setNcj_cellIndexPath:(NSIndexPath *)indexPath;

@end