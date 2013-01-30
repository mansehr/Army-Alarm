//
//  EditViewController.m
//  ArmyAlarm
//
//  Created by Adam Emery on 12/17/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import "EditViewController.h"
#import "DataController.h"
#import <QuartzCore/QuartzCore.h>
@interface EditViewController ()

@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 44)];
        label.font = [UIFont fontWithName:@"Army" size:40];
        label.textAlignment = UITextAlignmentCenter;
        label.text=@"Add Alarm";
        [self.view addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(34, 46, 252, 2)];
        [line setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:line];
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(34, 48, 252,129)];
        [table setDelegate:self];
        [table setDataSource:self];
        [table setBounces:false];
        [table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [table setSeparatorColor:[UIColor blackColor]];
        [table setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:table];
        
        
        
        UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(34, 216, 252, self.view.frame.size.height-256-32)];
        [picker setDelegate:self];
        [picker setDataSource:self];
        
        picker.layer.borderWidth = 2.0f;
        [self.view addSubview:picker];
        
                
        UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(34, self.view.frame.size.height-32, 80, 32)];
        [cancel.titleLabel setFont:[UIFont fontWithName:@"Army" size:22]];
        [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:cancel];
        
        UIButton* save = [[UIButton alloc] initWithFrame:CGRectMake(216, self.view.frame.size.height-32, 80, 32)];
        [save.titleLabel setFont:[UIFont fontWithName:@"Army" size:22]];
        [save setTitle:@"save" forState:UIControlStateNormal];
        [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:save];
        
    }
    return self;
}

- (void)cancel{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)save {
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Picker view crap

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        return 24;
    }
    return 60;
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row<10) {
        return [NSString stringWithFormat:@"0%d", row];
    }
    return [NSString stringWithFormat:@"%d", row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
 
NSLog(@"Selected Color: Index of selected color: %i", row);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [[cell textLabel] setFont:[UIFont fontWithName:@"Army" size:16]];
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    
    switch ([indexPath row]) {
    case 0:
        [[cell textLabel] setText:@"censored"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
   //     censor = [[UISwitch alloc] init];
     //   [cell setAccessoryView:censor];
        break;
    case 1:
        [[cell textLabel] setText:@"Snooze"];
        snooze = [[UISwitch alloc] init];
        [cell setAccessoryView:snooze];
        break;
    case 2:
        [[cell textLabel] setText:@"label"];
        alarmLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
        [alarmLabel setFont:[UIFont fontWithName:@"Army" size:14]];
        [alarmLabel setTextAlignment:NSTextAlignmentCenter];
        [alarmLabel setText:@"Alarm"];
        [cell setAccessoryView:alarmLabel];
        break;

    default:
    break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
