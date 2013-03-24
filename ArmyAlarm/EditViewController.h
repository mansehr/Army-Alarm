//
//  EditViewController.h
//  ArmyAlarm
//
//  Created by Adam Emery on 12/17/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView* table;
    UILabel* repeatLabel;
    UISwitch* censor;
    UISwitch* snooze;
    UITextField* alarmLabel;
    UIDatePicker* picker;
    BOOL editing;
    int editIndex;
}
- (void)loadValues:(NSDictionary*)alarmValues;
-(void)setEditIndex:(int)index;
@end
