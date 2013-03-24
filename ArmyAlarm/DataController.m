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


-(NSMutableArray*)getAlarms{
    if(data==nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"alarms.plist"];

        data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        if ([data objectForKey:@"Alarms"]==nil){
            NSLog(@"saving file");
            NSBundle *myBundle = [NSBundle mainBundle];
            NSString *myDictPath = [myBundle pathForResource: @"alarms" ofType: @"plist"];
            data = [[NSMutableDictionary alloc] initWithContentsOfFile: myDictPath];
            [data writeToFile:path atomically:YES];
        }
    }
    return [[NSMutableArray alloc] initWithArray:[data objectForKey:@"Alarms"]];
}
-(void)deleteAlarmAtIndex:(int)index{
    NSMutableArray* alarms = [self getAlarms];
    [alarms removeObjectAtIndex:index];
    [self setAlarms:alarms];
}

-(void)createAlarm:(NSDictionary*)newAlarm{
    NSMutableArray* alarms = [self getAlarms];
    [alarms addObject:newAlarm];
    [self setAlarms:alarms];
}

-(void)replaceAlarm:(NSDictionary*)newAlarm atIndex:(int)index {
    NSMutableArray* alarms = [self getAlarms];
    [alarms replaceObjectAtIndex:index withObject:newAlarm];
    [self setAlarms:alarms];
}
-(void)setAlarms:(NSMutableArray*)alarms{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"alarms.plist"];
    
    [data setObject:alarms forKey:@"Alarms"];
    [data writeToFile:path atomically:YES];
}


@end
