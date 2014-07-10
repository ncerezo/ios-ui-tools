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