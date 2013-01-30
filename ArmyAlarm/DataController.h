//
//  DataController.h
//  ArmyAlarm
//
//  Created by Adam Emery on 1/30/13.
//  Copyright (c) 2013 Adam Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject{
    NSMutableDictionary* alarms;
}
+(DataController*)sharedInstance;
-(NSMutableDictionary*)getAlarms;
@end
