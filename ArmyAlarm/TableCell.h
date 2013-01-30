//
//  TableCell.h
//  ArmyAlarm
//
//  Created by Adam Emery on 11/4/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface TableCell : UITableViewCell{
    CAGradientLayer* gradiantLayer;
    UILabel* dedescription;
}
@property(nonatomic,retain) UILabel* description;

@end
