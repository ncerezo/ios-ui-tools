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

#import "NCJTableFormViewController.h"
#import "UIViewController+NCJKeyboardAccessory.h"
#import "UITextField+NCJExtendedAttributes.h"

@interface NCJTableFormViewController ()

@end

@implementation NCJTableFormViewController

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
    [super viewDidDisappear:animated];
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