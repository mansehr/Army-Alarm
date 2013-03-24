//
//  MainViewController.h
//  ArmyAlarm
//
//  Created by Adam Emery on 11/4/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView* table;
    BOOL editing;
    UINavigationItem *item;
    UIButton* edit;
}
@end
