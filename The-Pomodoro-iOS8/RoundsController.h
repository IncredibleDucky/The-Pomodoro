//
//  RoundsController.h
//  The-Pomodoro-iOS8
//
//  Created by Mattthew Bailey on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundsController : NSObject

@property (strong, nonatomic, readonly) NSArray *roundTimes;
@property (nonatomic, readwrite) NSInteger currentRound;

+(RoundsController *)sharedInstance;

- (void)roundSelected;
@end
