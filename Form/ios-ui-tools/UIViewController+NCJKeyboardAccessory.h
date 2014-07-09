//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void (^NCJKeyboardAccessoryTextFieldBlock)(UITextField *);

@interface UIViewController (NCJKeyboardAccessory) <UITextFieldDelegate>

- (UIScrollView *)ncj_viewToResize;
- (void)setNcj_viewToResize:(UIScrollView *)view;

- (UITextField *)ncj_currentTextField;
- (void)setNcj_currentTextField:(UITextField *)textField;

- (NSIndexPath *)ncj_currentTextFieldIndexPath;
- (void)setNcj_currentTextFieldIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)ncj_nextIndexPath;

- (void)setNcj_nextIndexPath:(NSIndexPath *)indexPath;

- (NSMutableArray *)ncj_sortedTextFields;
- (void)setNcj_sortedTextFields:(NSMutableArray *)array;

- (NCJKeyboardAccessoryTextFieldBlock)ncj_goBlock;
- (void)setNcj_goBlock:(NCJKeyboardAccessoryTextFieldBlock)block;

- (NSObject<UITextFieldDelegate> *)ncj_textFieldDelegate;
- (void)setNcj_textFieldDelegate:(NSObject<UITextFieldDelegate> *)delegate;

- (void)ncj_registerKeyboardAccessoryHandler;
- (void)ncj_unregisterKeyboardAccessoryHandler;

- (NSString *)ncj_prevButtonImageName;
- (void)setNcj_prevButtonImageName:(NSString *)imageName;

- (NSString *)ncj_nextButtonImageName;
- (void)setNcj_nextButtonImageName:(NSString *)imageName;

@end