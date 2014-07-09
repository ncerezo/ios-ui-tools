//
//  NCJViewController.m
//  Form
//
//  Created by Narciso Cerezo Jiménez on 08/07/14.
//  Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//

#import "NCJViewController.h"
#import "UIViewController+NCJKeyboardAccessory.h"
#import "UITextField+NCJExtendedAttributes.h"

@interface NCJViewController ()

@end

@implementation NCJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 50, 0.0);

    self.ncj_viewToResize = _tableView;
    self.ncj_sortedTextFields = [NSMutableArray array];

    __unsafe_unretained typeof(self) weakSelf = self;
    self.ncj_goBlock = ^( UITextField *field ) {
        [weakSelf.ncj_sortedTextFields enumerateObjectsUsingBlock:^( id obj, NSUInteger idx, BOOL *stop ) {
            ((UITextField *) obj).text = @"";
        }];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self ncj_registerKeyboardAccessoryHandler];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self ncj_unregisterKeyboardAccessoryHandler];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UITextField *textField = (UITextField *) [cell viewWithTag:1];
    textField.placeholder = [NSString stringWithFormat:@"Text %d", indexPath.row];
    textField.delegate = self;
    textField.ncj_cellIndexPath = indexPath;
    // We're assuming here for the sake of simplicity that this is called in the row order
    if( ![self.ncj_sortedTextFields containsObject:textField] ) {
        [self.ncj_sortedTextFields addObject:textField];
    }
    if( indexPath.row == 2 ) {
        textField.returnKeyType = UIReturnKeyGo;
    }
    else {
        textField.returnKeyType = UIReturnKeyNext;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *textField = (UITextField *) [cell viewWithTag:1];
    [textField becomeFirstResponder];
}

@end