//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Mattthew Bailey on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"
@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(updateTimerLabel) name:SecondTickNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:TimerCompleteNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:TimerCompleteNotification object:nil];
        
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue
 sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)updateTimerLabel {
        self.timerLabel.text = [[Timer sharedInstance] timeRemaining];
}

- (IBAction)timerButtonPressed:(id)sender {
    if([Timer sharedInstance].isOn == NO)
    {
    [[Timer sharedInstance] startTimer];
    }
}

- (void)newRound {
    [self updateTimerLabel];
    [self timerButtonPressed:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
