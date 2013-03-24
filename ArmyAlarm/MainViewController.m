//
//  MainViewController.m
//  ArmyAlarm
//
//  Created by Adam Emery on 11/4/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import "MainViewController.h"
#import "PreviewViewController.h"
#import "EditViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DataController.h"
#import "TableCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 44)];
        label.font = [UIFont fontWithName:@"Army" size:40];
        label.textAlignment = UITextAlignmentCenter;
        label.text=@"Army Alarm";
        [self.view addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(34, 46, 252, 2)];
        [line setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:line];
        
        
        edit = [[UIButton alloc] initWithFrame:CGRectMake(34, 50, 76, 32)];
        [edit.titleLabel setFont:[UIFont fontWithName:@"Army" size:28]];
        [edit.titleLabel setTextAlignment:UITextAlignmentRight];
        [edit setTitle:@"edit" forState:UIControlStateNormal];
        [edit setTitle:@"done" forState:UIControlStateSelected];
        [edit addTarget:self action:@selector(editAlarm:) forControlEvents:UIControlEventTouchUpInside];
        [edit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [edit setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [self.view addSubview:edit];
        
        UIButton* add = [[UIButton alloc] initWithFrame:CGRectMake(224, 50, 60, 32)];
        [add.titleLabel setFont:[UIFont fontWithName:@"Army" size:28]];
        [add setTitle:@"add" forState:UIControlStateNormal];
        [add addTarget:self action:@selector(addAlarm) forControlEvents:UIControlEventTouchUpInside];
        [add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:add];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(34, 78, 252, 1)];
        [line2 setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:line2];
        
        UIImageView* drill = [[UIImageView alloc] initWithFrame:CGRectMake(34, 256, 252, self.view.frame.size.height-256-32)];
        
        [drill setImage:[UIImage imageNamed:@"Drill.jpeg"]];
        [drill setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:drill];
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(34, 84, 252,168)];
        [table setAllowsSelectionDuringEditing:YES];
        [table setDelegate:self];
        [table setDataSource:self];
        [table setBounces:false];
        [table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [table setSeparatorColor:[UIColor blackColor]];
        [table setBackgroundColor:[UIColor clearColor]];
        [self.view  addSubview:table];
        
        UIButton* info = [[UIButton alloc] initWithFrame:CGRectMake(34, self.view.frame.size.height-32, 56, 32)];
        [info.titleLabel setFont:[UIFont fontWithName:@"Army" size:22]];
        [info setTitle:@"info" forState:UIControlStateNormal];
        [info addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
        [info setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:info];
        
        UIButton* preview = [[UIButton alloc] initWithFrame:CGRectMake(184, self.view.frame.size.height-32, 130, 32)];
        [preview.titleLabel setFont:[UIFont fontWithName:@"Army" size:22]];
        [preview setTitle:@"Preview" forState:UIControlStateNormal];
        [preview addTarget:self action:@selector(previewAlarms) forControlEvents:UIControlEventTouchUpInside];
        [preview setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:preview];
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [table reloadData];

}

-(void)addAlarm{
    EditViewController* editView = [[EditViewController alloc] init];

    [self presentViewController:editView animated:NO completion:nil];
    [editView loadValues:nil];
}

-(void)modifyAlarm:(int)index{
    EditViewController* editView = [[EditViewController alloc] init];

    [self presentViewController:editView animated:NO completion:nil];
    NSDictionary* dict = [[[DataController sharedInstance] getAlarms] objectAtIndex:index];
    [editView setEditIndex:index];
    [editView loadValues:dict];
}

-(void)editAlarm:(UIButton*)button{
    [button setSelected:!button.selected];
    editing=!editing;
    [table setEditing:editing animated:YES];
}
-(void)previewAlarms{
    PreviewViewController* preview = [[PreviewViewController alloc] init];
    [self presentViewController:preview animated:NO completion:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];

}

-(void)showInfo{
    UIAlertView* info = [[UIAlertView alloc] initWithTitle:@"About Army Alarm" message:@"Army Alarm Version 2.0\nPowered by\nSilver Dragon Technologies, LLC" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];

    [info show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[DataController sharedInstance] getAlarms] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSMutableDictionary* details = [[[DataController sharedInstance] getAlarms] objectAtIndex:[indexPath row]];
    
    UIButton* onOff = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72, 64)];
    [onOff setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
    [onOff setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
    [onOff setImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateSelected];
    [onOff addTarget:cell action:@selector(setOnOff:) forControlEvents:UIControlEventTouchUpInside];
    [cell setAccessoryView:onOff];
    
    NSDate* date = [details objectForKey:@"date"];
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm a"];
    
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    [[cell textLabel] setText: [format stringFromDate:date]];
    [[cell description] setText:[details objectForKey:@"title"]];

    [cell setEditingAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataController sharedInstance] deleteAlarmAtIndex:[indexPath row]];
        [tableView reloadData];
    }    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([table isEditing]) {
        [self modifyAlarm:[indexPath row]];
        [self editAlarm:edit];
    }
}

@end
