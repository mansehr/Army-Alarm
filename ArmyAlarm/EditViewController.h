//
//  EditViewController.h
//  ArmyAlarm
//
//  Created by Adam Emery on 12/17/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>{
    UITableView* table;
    UILabel* repeatLabel;
    UISwitch* censor;
    UISwitch* snooze;
    UILabel* alarmLabel;
}
@end
