//
//  PreviewViewController.m
//  ArmyAlarm
//
//  Created by Adam Emery on 12/16/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import "PreviewViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PreviewViewController ()

@end

@implementation PreviewViewController
@synthesize player;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 44)];
        label.font = [UIFont fontWithName:@"Army" size:30];
        label.textAlignment = UITextAlignmentCenter;
        label.text=@"Preview Alarms";
        [self.view addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(34, 46, 252, 2)];
        [line setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:line];
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(34, 48, 252,168)];
        [table setDelegate:self];
        [table setDataSource:self];
        [table setBounces:false];
        [table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [table setSeparatorColor:[UIColor blackColor]];
        [table setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:table];
        
        UIImageView* drill = [[UIImageView alloc] initWithFrame:CGRectMake(34, 256, 252, self.view.frame.size.height-256-32)];
        
        [drill setImage:[UIImage imageNamed:@"Drill.jpeg"]];
        [drill setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:drill];
        
        UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(98, self.view.frame.size.height-32, 130, 32)];
        [cancel.titleLabel setFont:[UIFont fontWithName:@"Army" size:22]];
        [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:cancel];
        if([SKPaymentQueue canMakePayments]){
            NSLog(@"mad money");
        }
        
        //unlocked=true;

    }
    return self;
}

- (void)requestProductData{
    NSLog(@"requesting");
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:
            [NSSet setWithObject: @"com.quinnydinny.thing2"]];
    request.delegate = self;
   
    [request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *myProducts = response.products;
    NSLog(@"%@",myProducts);
    // Populate your UI from the products list.
    // Save a reference to the products list.
}

-(void)play:(NSString*)alarmName{
    NSString* path = [[NSBundle mainBundle] pathForResource:alarmName ofType:@"mp3"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: path];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
    [player setDelegate: self];
   // [player prepareToPlay];
    [player play];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer*)audioPlayer successfully:(BOOL)completed {
    if (completed == YES) {
        [audioPlayer play];
    }
}
- (void)cancel{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (unlocked) {
        return 6;
    }
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
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
    switch ([indexPath row]) {
        case 0:
            [[cell textLabel] setText:@"First Alarm Sound"];
            [cell.imageView setImage:[UIImage imageNamed:@"play.png"]];  
            break;
        case 1:
            [[cell textLabel] setText:@"After First Snooze"];
            [cell.imageView setImage:[UIImage imageNamed:@"play.png"]];  
            break;
        case 2:
            [[cell textLabel] setText:@"After Second Snooze"];
            [cell.imageView setImage:[UIImage imageNamed:@"play.png"]];  
            break;
        case 3:
            if (unlocked) {
                [[cell textLabel] setText:@"First Uncensored"];
                [cell.imageView setImage:[UIImage imageNamed:@"play.png"]];
            }else{
                [[cell textLabel] setFont:[UIFont fontWithName:@"Army" size:12]];
                [[cell textLabel] setText:@"      Purchase Uncensored sounds"];
            }
            break;
        case 4:
                [[cell textLabel] setText:@"After First Uncensored"];
                [cell.imageView setImage:[UIImage imageNamed:@"play.png"]];
            break;
        case 5:
            [[cell textLabel] setText:@"After Second Uncensored"];
            [cell.imageView setImage:[UIImage imageNamed:@"play.png"]];
            break;

        default:
        break;
}

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!unlocked&&[indexPath row]==3) {
        [self requestProductData];
    }
    else{
        
        NSString *mediaFileName = [[[player.url absoluteString] lastPathComponent] stringByReplacingOccurrencesOfString:@".mp3" withString:@""];
        
        NSString *pressFileName = [NSString stringWithFormat:@"%d",[indexPath row]];
        
        if ([player isPlaying]&&[mediaFileName isEqualToString:pressFileName]) {
            [player stop];
            [[[tableView cellForRowAtIndexPath:indexPath] imageView] setImage:[UIImage imageNamed:@"play.png"]];
        }else{
            if ([player isPlaying]){
                int row = [mediaFileName intValue];
                NSIndexPath* index =[NSIndexPath indexPathForRow:row inSection:0];
                [[[tableView cellForRowAtIndexPath:index] imageView] setImage:[UIImage imageNamed:@"play.png"]];
            }
            [[[tableView cellForRowAtIndexPath:indexPath] imageView] setImage:[UIImage imageNamed:@"pause.png"]];
            [self play:pressFileName];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
