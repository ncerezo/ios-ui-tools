//
// Created by Narciso Cerezo Jiménez on 08/07/14.
// Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//


#import "UIViewController+NCJKeyboardAccessory.h"
#import "NCJUITheme.h"
#import "NCJAppSingleton.h"
#import "NSObject+NCJProtocolOptionalMethod.h"
#import "UITextField+NCJExtendedAttributes.h"

#import <objc/runtime.h>

static void *NCJKeyboardAccessoryViewToResizeKey;
static void *NCJKeyboardAccessoryCurrentTextFieldKey;
static void *NCJKeyboardAccessoryCurrentTextFieldIndexPathKey;
static void *NCJKeyboardAccessorySortedTextFieldsKey;
static void *NCJKeyboardAccessoryReturnBlockKey;
static void *NCJKeyboardAccessoryKeyboardVisibleKey;
static void *NCJKeyboardAccessoryViewHeightKey;
static void *NCJKeyboardAccessoryAccessoryViewKey;
static void *NCJKeyboardAccessoryNextIndexPathKey ;
static void *NCJKeyboardAccessoryPreviousButtonKey ;
static void *NCJKeyboardAccessoryNextButtonKey ;
static void *NCJKeyboardAccessoryTextFieldDelegateKey ;
static void *NCJKeyboardAccessoryPrevImageNameKey ;
static void *NCJKeyboardAccessoryNextImageNameKey ;

@implementation UIViewController (NCJKeyboardAccessory)

#pragma mark - Custom property accessors

- (UIScrollView *)ncj_viewToResize {
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryViewToResizeKey );
}

- (void)setNcj_viewToResize:(UIScrollView *)view {
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ncj_handleTap)];
    tapper.cancelsTouchesInView = NO;
    [view addGestureRecognizer:tapper];

    objc_setAssociatedObject( self, &NCJKeyboardAccessoryViewToResizeKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextField *)ncj_currentTextField{
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryCurrentTextFieldKey );
}

- (void)setNcj_currentTextField:(UITextField *)textField{
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryCurrentTextFieldKey, textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)ncj_currentTextFieldIndexPath {
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryCurrentTextFieldIndexPathKey );
}

- (void)setNcj_currentTextFieldIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryCurrentTextFieldIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)ncj_nextIndexPath {
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryNextIndexPathKey );
}

- (void)setNcj_nextIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryNextIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)ncj_sortedTextFields{
    return objc_getAssociatedObject( self, &NCJKeyboardAccessorySortedTextFieldsKey );
}

- (void)setNcj_sortedTextFields:(NSMutableArray *)array{
    objc_setAssociatedObject( self, &NCJKeyboardAccessorySortedTextFieldsKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)ncj_previousViewHeight{
    NSNumber *number = objc_getAssociatedObject( self, &NCJKeyboardAccessoryViewHeightKey );
    return number ? [number floatValue] : 0.0f;
}

- (void)setNcj_previousViewHeight:(CGFloat)height{
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryViewHeightKey, [NSNumber numberWithFloat:height], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBarButtonItem *)ncj_previousButton{
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryPreviousButtonKey );
}

- (void)setNcj_previousButton:(UIBarButtonItem *)button{
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryPreviousButtonKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBarButtonItem *)ncj_nextButton{
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryNextButtonKey );
}

- (void)setNcj_nextButton:(UIBarButtonItem *)button{
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryNextButtonKey, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NCJKeyboardAccessoryTextFieldBlock)ncj_goBlock{
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryReturnBlockKey );
}

- (void)setNcj_goBlock:(NCJKeyboardAccessoryTextFieldBlock)block{
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryReturnBlockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObject <UITextFieldDelegate> *)ncj_textFieldDelegate {
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryTextFieldDelegateKey );
}

- (void)setNcj_textFieldDelegate:(NSObject <UITextFieldDelegate> *)delegate {
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryTextFieldDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)ncj_prevButtonImageName {
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryPrevImageNameKey );
}

- (void)setNcj_prevButtonImageName:(NSString *)imageName {
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryPrevImageNameKey, imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)ncj_nextButtonImageName {
    return objc_getAssociatedObject( self, &NCJKeyboardAccessoryNextImageNameKey );
}

- (void)setNcj_nextButtonImageName:(NSString *)imageName {
    objc_setAssociatedObject( self, &NCJKeyboardAccessoryNextImageNameKey, imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - public methods

- (void)ncj_registerKeyboardAccessoryHandler {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ncj_keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ncj_keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)ncj_unregisterKeyboardAccessoryHandler {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private property accessors

- (BOOL)ncj_keyboardVisible {
    NSNumber *shown = objc_getAssociatedObject( self, &NCJKeyboardAccessoryKeyboardVisibleKey );
    if( shown == nil ) {
        shown = [NSNumber numberWithBool:NO];
        objc_setAssociatedObject( self, &NCJKeyboardAccessoryKeyboardVisibleKey, shown, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [shown boolValue];
}

- (void)setNcj_keyboardVisible:(BOOL)shown {
    objc_setAssociatedObject(
            self,
            &NCJKeyboardAccessoryKeyboardVisibleKey,
            [NSNumber numberWithBool:shown],
            OBJC_ASSOCIATION_RETAIN_NONATOMIC
    );
}


- (UIToolbar *)ncj_inputAccessoryToolbar {
    UIToolbar *toolbar = objc_getAssociatedObject( self, &NCJKeyboardAccessoryAccessoryViewKey );
    if( !toolbar ) {
        toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50.0f)];
        toolbar.barStyle = UIBarStyleDefault;
        NSMutableArray *items = [NSMutableArray array];
        NCJUITheme *theme = [NCJAppSingleton sharedInstance].currentTheme;
        if( self.ncj_sortedTextFields ) {
            UIBarButtonItem *previousButton;
            if( self.ncj_prevButtonImageName ) {
                previousButton = [[UIBarButtonItem alloc]
                        initWithImage:[UIImage imageNamed:self.ncj_prevButtonImageName]
                                style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(ncj_goToPreviousField)];
            }
            else {
                previousButton = [[UIBarButtonItem alloc]
                        initWithTitle:NSLocalizedString(@"Prev", nil)
                                style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(ncj_goToPreviousField)];
            }
            previousButton.tintColor = theme.tintColor;
            self.ncj_previousButton = previousButton;

            UIBarButtonItem *nextButton;
            if( self.ncj_nextButtonImageName ) {
                nextButton = [[UIBarButtonItem alloc]
                       initWithImage:[UIImage imageNamed:self.ncj_nextButtonImageName]
                               style:UIBarButtonItemStyleBordered
                              target:self
                              action:@selector(ncj_goToNextField)];
            }
            else {
                nextButton = [[UIBarButtonItem alloc]
                       initWithTitle:NSLocalizedString(@"Next", nil)
                               style:UIBarButtonItemStyleBordered
                              target:self
                              action:@selector(ncj_goToNextField)];
            }
            nextButton.tintColor = theme.tintColor;
            self.ncj_nextButton = nextButton;

            [items addObject:previousButton];
            UIBarButtonItem *separator = [[UIBarButtonItem alloc]
                                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                target:nil
                                                                                action:nil];
            separator.width = 20.0f;
            [items addObject:separator];
            [items addObject:nextButton];
        }
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                       target:nil
                                                                       action:nil]];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(ncj_textFieldDone)];
        doneButton.tintColor = theme.tintColor;
        [items addObject:doneButton];
        toolbar.items = items;
        [toolbar sizeToFit];
        toolbar.alpha = 0.5f;
        objc_setAssociatedObject( self, &NCJKeyboardAccessoryAccessoryViewKey, toolbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self updatePrevNextButtonState];
    }
    return toolbar;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if( textField.returnKeyType == UIReturnKeyGo && self.ncj_goBlock ) {
        self.ncj_goBlock( textField );
        return YES;
    }

    NSMutableArray *sortedTextFields = self.ncj_sortedTextFields;
    if( textField.returnKeyType == UIReturnKeyNext && sortedTextFields ) {
        [self ncj_goToNextField];
    }
    else {
        [self ncj_restoreViews];
        [textField resignFirstResponder];
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if( textField.enabled ) {
        self.ncj_currentTextField = textField;
        if( [self.ncj_viewToResize isKindOfClass:[UITableView class]] ) {
            self.ncj_currentTextFieldIndexPath = textField.ncj_cellIndexPath;
            if( self.ncj_currentTextFieldIndexPath == nil ) {
                UITableViewCell *cell = nil;
                UIView *superView = textField.superview;
                while( superView != nil && cell == nil ) {
                    if( [superView isKindOfClass:[UITableViewCell class]] ) {
                        cell = (UITableViewCell *) superView;
                    }
                    else {
                        superView = superView.superview;
                    }
                }
                if( cell ) {
                    NSIndexPath *path = [( (UITableView *) self.ncj_viewToResize ) indexPathForCell:cell];
                    textField.ncj_cellIndexPath = path;
                    self.ncj_currentTextFieldIndexPath = path;
                }
            }
            [self updatePrevNextButtonState];
        }
        if( !textField.inputAccessoryView ) {
            textField.inputAccessoryView = [self ncj_inputAccessoryToolbar];
        }
    }
    if( self.ncj_textFieldDelegate ) {
        [self.ncj_textFieldDelegate performBlock:^{
            [self.ncj_textFieldDelegate textFieldDidBeginEditing:textField];
        } ifRespondsTo:@selector(textFieldDidBeginEditing:)];
    }
}


#pragma mark - private methods

- (void)ncj_goToNextField {
    NSArray *sortedFields = self.ncj_sortedTextFields;
    UITextField *currentTextField = self.ncj_currentTextField;
    if( sortedFields && currentTextField ) {
        NSUInteger index = [sortedFields indexOfObject:currentTextField];
        if( index == NSNotFound ) {
            index = [sortedFields indexOfObject:self.ncj_currentTextFieldIndexPath];
        }
        if( index != NSNotFound ) {
            if( index < (sortedFields.count - 1) ) {
                index++;
                [self ncj_goToFieldAtIndex:index];
            }
        }
    }
}

- (void)ncj_goToFieldAtIndex:(NSUInteger)index {
    if( [self.ncj_viewToResize isKindOfClass:[UITableView class]] ) {
        id target = [self.ncj_sortedTextFields objectAtIndex:index];
        NSIndexPath *indexPath = nil;
        if( [target isKindOfClass:[UITextField class]] ) {
            indexPath = ((UITextField *) target).ncj_cellIndexPath;
        }
        else if( [target isKindOfClass:[NSIndexPath class]] ) {
            indexPath = target;
        }

        if( indexPath ) {
            UITableView *tableView = (UITableView *)self.ncj_viewToResize;
            self.ncj_nextIndexPath = indexPath;

            [tableView scrollToRowAtIndexPath:indexPath
                             atScrollPosition:UITableViewScrollPositionNone
                                     animated:YES];
            [tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
    else {
        UITextField *nextTextField = (UITextField *) [self.ncj_sortedTextFields objectAtIndex:index];
        [nextTextField becomeFirstResponder];
    }

}

- (void)ncj_goToPreviousField {
    NSArray *sortedFields = self.ncj_sortedTextFields;
    UITextField *currentTextField = self.ncj_currentTextField;
    if( sortedFields && currentTextField ) {
        NSUInteger index = [sortedFields indexOfObject:currentTextField];
        if( index == NSNotFound ) {
            index = [sortedFields indexOfObject:self.ncj_currentTextFieldIndexPath];
        }
        if( index != NSNotFound ) {
            if( index > 0 ) {
                index--;
                [self ncj_goToFieldAtIndex:index];
            }
        }
    }
}

- (void)ncj_handleTap {
    [self ncj_restoreViews];
    [self.view endEditing:YES];
}

- (void)ncj_textFieldDone {
    [self ncj_restoreViews];
    [self.ncj_currentTextField resignFirstResponder];
}

- (void)ncj_keyboardDidShow: (NSNotification *) notification {
    if( self.ncj_keyboardVisible ) {
        return;
    }

    NSDictionary* info = [notification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;

    UIScrollView *scrollView = self.ncj_viewToResize;
    self.ncj_previousViewHeight = scrollView.frame.size.height;
    CGRect frame = scrollView.frame;
    frame.size.height = frame.size.height -
                        ( UIDeviceOrientationIsPortrait(self.interfaceOrientation) ?
                                keyboardSize.height :
                                keyboardSize.width
                        );
    scrollView.frame = frame;
    if( ![scrollView isKindOfClass:[UITableView class]] ) {
        CGFloat maxY = 0.0f;
        CGFloat contentWidth = 0.0f;
        for( NSUInteger i = 0; i < scrollView.subviews.count; i++ ) {
            UIView *subView = [scrollView.subviews objectAtIndex:i];
            if( !subView.hidden ) {
                contentWidth = MAX( contentWidth, subView.frame.size.width );
                maxY = MAX( maxY, subView.frame.origin.y + subView.frame.size.height );
            }
        }
        [scrollView setContentSize:CGSizeMake( contentWidth, maxY )];
        UITextField *currentTextField = self.ncj_currentTextField;
        if( currentTextField ) {
            [scrollView scrollRectToVisible:currentTextField.frame animated:YES];
        }
    }

    self.ncj_keyboardVisible = YES;
}

- (void)ncj_keyboardDidHide: (NSNotification *) notification {
    if( !self.ncj_keyboardVisible ) {
        return;
    }

    [self ncj_restoreViews];
    self.ncj_keyboardVisible = NO;
}

- (void)ncj_restoreViews {
    if( self.ncj_previousViewHeight > 0 ) {
        UIScrollView *scrollView = self.ncj_viewToResize;
        CGRect frame = scrollView.frame;
        frame.size.height = self.ncj_previousViewHeight;
        scrollView.frame = frame;
    }
}


- (void)updatePrevNextButtonState {
    self.ncj_nextButton.enabled = NO;
    self.ncj_previousButton.enabled = NO;
    if( self.ncj_currentTextFieldIndexPath ) {
        NSArray *sortedFields = self.ncj_sortedTextFields;
        UITextField *currentTextField = self.ncj_currentTextField;
        if( sortedFields && currentTextField ) {
            NSUInteger index = [sortedFields indexOfObject:currentTextField];
            if( index == NSNotFound ) {
                index = [sortedFields indexOfObject:self.ncj_currentTextFieldIndexPath];
            }
            if( index != NSNotFound ) {
                self.ncj_nextButton.enabled = index < (sortedFields.count - 1);
                self.ncj_previousButton.enabled = index > 0;
            }
        }
    }
}

@end