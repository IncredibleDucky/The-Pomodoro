//
//  RoundsViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Mattthew Bailey on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"
#import "RoundsController.h"
#import "Timer.h"

static NSString * const cellID = @"CellID";

@interface RoundsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation RoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.tableView];
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roundComplete) name:TimerCompleteNotification object:nil];

    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    NSArray *tempArray = [RoundsController sharedInstance].roundTimes;
    NSString *tempString = [tempArray objectAtIndex:indexPath.row];
    NSInteger time = [tempString integerValue];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", time];
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[RoundsController sharedInstance].roundTimes count];
    
}

-(void)registerClass:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [RoundsController sharedInstance].currentRound = indexPath.row;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound  inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [[RoundsController sharedInstance] roundSelected];
    
}
-(void)roundComplete {
    if([[RoundsController sharedInstance].roundTimes lastObject] != [[RoundsController sharedInstance].roundTimes objectAtIndex:[RoundsController sharedInstance].currentRound]) {
        [RoundsController sharedInstance].currentRound++;
        [[RoundsController sharedInstance] roundSelected];
    }
    else {
        [RoundsController sharedInstance].currentRound = 0;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound  inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [[RoundsController sharedInstance] roundSelected];
         }
}
         
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.


@end
