//
//  NCJViewController.h
//  Form
//
//  Created by Narciso Cerezo Jiménez on 08/07/14.
//  Copyright (c) 2014 Narciso Cerezo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCJViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end