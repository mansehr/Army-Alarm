//
//  DataController.h
//  ArmyAlarm
//
//  Created by Adam Emery on 1/30/13.
//  Copyright (c) 2013 Adam Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject{
    NSMutableDictionary* data;
}
+(DataController*)sharedInstance;
-(NSMutableArray*)getAlarms;
-(void)deleteAlarmAtIndex:(int)index;
-(void)setAlarms:(NSMutableArray*)alarms;
-(void)createAlarm:(NSDictionary*)newAlarm;
-(void)replaceAlarm:(NSDictionary*)newAlarm atIndex:(int)index;
@end
