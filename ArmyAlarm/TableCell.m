//
//  TableCell.m
//  ArmyAlarm
//
//  Created by Adam Emery on 11/4/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize description;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        description = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
        [description setFont:[UIFont fontWithName:@"Army" size:12]];
        [description setNumberOfLines:1];
        [description setTextAlignment:NSTextAlignmentLeft];
        [description setBackgroundColor:[UIColor clearColor]];
        [self addSubview:description];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) layoutSubviews {
    [super layoutSubviews];
     
    [[self textLabel] setFont:[UIFont fontWithName:@"Army" size:18]];
    [[self detailTextLabel] setFont:[UIFont fontWithName:@"Army" size:13]];
    [[self detailTextLabel] setTextColor:[UIColor greenColor]];
    [[self textLabel] setShadowColor:[UIColor whiteColor]];
    [[self textLabel] setShadowOffset:CGSizeMake(1, 0)];
   // [description setFrame:CGRectMake(100, 4, 110, 32)];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    int x = 100;
    if (editing) {
        x+=34;
    }
    else{
        x+=4;
    }
    [UIView beginAnimations:@"MoveAndStrech" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [description setFrame:CGRectMake(x, 6, 110, 30)];
    [UIView commitAnimations];

    
}
-(void)setOnOff:(UIButton*)button{
    [button setSelected:!button.selected];
}
@end
