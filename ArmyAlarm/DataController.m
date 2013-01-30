//
//  DataController.m
//  ArmyAlarm
//
//  Created by Adam Emery on 1/30/13.
//  Copyright (c) 2013 Adam Emery. All rights reserved.
//

#import "DataController.h"
static DataController *sharedInstance = nil;
@implementation DataController
+(DataController*)sharedInstance {
	@synchronized(self) {
		if (!sharedInstance) {
			sharedInstance = [[DataController alloc] init];
		}
	}
	return sharedInstance;
}

-(NSMutableDictionary*)getAlarms{
    alarms = [[NSMutableDictionary alloc] init];
    return alarms;
}
@end
