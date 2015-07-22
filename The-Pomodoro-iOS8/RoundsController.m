//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Mattthew Bailey on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"
#import "Timer.h"
@implementation RoundsController

- (NSArray *)roundTimes {
    return @[@1500, @300, @1500, @300, @1500, @300, @1500, @900];
}

+ (RoundsController *)sharedInstance {
    static RoundsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RoundsController new];
        //Instantiate Shared Instance Properties
        
    });
    return sharedInstance;
}

- (void)roundSelected {
  //Timer  *timer = [[self roundTimes] objectAtIndex:self.currentRound];
    [Timer sharedInstance].seconds = [[[self roundTimes] objectAtIndex:self.currentRound] integerValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundNotification object:nil];
    [[Timer sharedInstance] cancelTimer];
}


@end
