//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Mattthew Bailey on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

@implementation Timer

+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [Timer new];
 //Instantiate Shared Instance Properties
        sharedInstance.seconds = 605;
    });
    return sharedInstance;
}

- (void)startTimer{
    self.isOn = YES;
    [self checkActive];
}

- (void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void) endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerCompleteNotification object:nil];
}

- (void) decreaseSecond {
    self.seconds--;
    [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    if (self.seconds == 0) {
        [self endTimer];
    }
}

- (void) checkActive {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if(self.isOn == YES) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1.0];
    }
}

- (NSString *)timeRemaining {

    NSInteger minutes = self.seconds / 60;
    NSInteger seconds = self.seconds % 60;
    
    NSMutableString *timeString = [NSMutableString new];

    if(minutes < 10){
        [timeString appendString:[NSString stringWithFormat:@"0%ld:", (long)minutes]];
    }
    else {
        [timeString appendString:[NSString stringWithFormat:@"%ld:", (long)minutes]];
    }
    
    if(seconds < 10){
        [timeString appendString:[NSString stringWithFormat:@"0%ld", (long)seconds]];
    }
    else {
        [timeString appendString:[NSString stringWithFormat:@"%ld", (long)seconds]];
    }
    
    return timeString;
    
}

@end
