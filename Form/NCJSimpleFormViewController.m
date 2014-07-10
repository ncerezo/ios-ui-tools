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

#import "NCJSimpleFormViewController.h"


@implementation NCJSimpleFormViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ncj_viewToResize = _scrollView;
    self.ncj_sortedTextFields = [NSMutableArray array];
    [self.ncj_sortedTextFields addObjectsFromArray:@[ _textField1, _textField2, _textField3 ]];

    __unsafe_unretained typeof(self) weakSelf = self;
    self.ncj_goBlock = ^( UITextField *field ) {
        weakSelf.label.text = field.text;
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self ncj_registerKeyboardAccessoryHandler];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self ncj_unregisterKeyboardAccessoryHandler];
}

@end