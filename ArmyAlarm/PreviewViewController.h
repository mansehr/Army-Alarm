//
//  PreviewViewController.h
//  ArmyAlarm
//
//  Created by Adam Emery on 12/16/12.
//  Copyright (c) 2012 Adam Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <StoreKit/StoreKit.h>
@interface PreviewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AVAudioPlayerDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver>{
    UITableView* table;
    AVAudioPlayer *player;
    BOOL unlocked;
}
@property (nonatomic, retain) AVAudioPlayer *player;
@end
