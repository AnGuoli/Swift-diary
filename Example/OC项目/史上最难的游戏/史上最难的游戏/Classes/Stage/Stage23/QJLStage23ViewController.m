//
//  QJLStage23ViewController.m
//  Game
//
//  Created by 金亮齐 on 16/8/12.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

#import "QJLStage23ViewController.h"
#import "QJLStage10BottomNumView.h"
#import "QJLStage23PeopleView.h"
#import "QJLBusView.h"
#import "QJLCountTimeView.h"
#import "PrefixHeader.pch"

@interface QJLStage23ViewController ()

@property (nonatomic, strong) QJLStage10BottomNumView *numView;
@property (nonatomic, strong) QJLStage23PeopleView *peopleView;
@property (nonatomic, strong) QJLBusView *busView;
@property (nonatomic, assign) int onceTime;
@property (nonatomic, assign) int allScore;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) BOOL playAgain;

@end

@implementation QJLStage23ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildStageInfo];
}

- (void)buildStageInfo {
    [self removeAllImageView];
    
    [self buildBottomNumberView];
    
    [self buildBgImageView];
    
    [self buildPeopleView];
    
    [self buildBusView];
    
    [self addButtonsActionWithTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self buildStageView];
    
    [self bringPauseAndPlayAgainToFront];
}

- (void)buildBusView {
    self.busView = [QJLBusView viewFromNib];
    self.busView.frame = CGRectMake(-(self.busView.frame.size.width - ScreenWidth) * 0.5 + self.busView.frame.size.width, 130, self.busView.frame.size.width, self.busView.frame.size.height);
    [self.view addSubview:self.busView];
    
    __weak typeof(self) weakSelf = self;
    self.busView.busPassFinish = ^{
        weakSelf.playAgain = NO;
        weakSelf.count++;
        weakSelf.numView.hidden = NO;
        weakSelf.peopleView.hidden = NO;
        [weakSelf setButtonsIsActivate:YES];
        [(QJLCountTimeView *)weakSelf.countScore startCalculateByTimeWithTimeOut:^{
            [(QJLCountTimeView *)weakSelf.countScore stopCalculateByTimeWithTimeBlock:nil];
            weakSelf.view.userInteractionEnabled = NO;
            
            [weakSelf buildTimeOutView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf showGameFail];
            });
            
        } outTime:3];
    };
    
    self.busView.stopCountTime = ^{
        [(QJLCountTimeView *)weakSelf.countScore stopCalculateByTimeWithTimeBlock:^(int second, int ms) {
            weakSelf.onceTime = second * 1000 + ms / 60.0 * 1000;
        }];
    };
    
    self.busView.guessSucess = ^{
        weakSelf.allScore += weakSelf.onceTime;
        [weakSelf setButtonsIsActivate:NO];
        QJLResultStateType type;
        
        if (weakSelf.onceTime < 400) {
            type = QJLResultStateTypePerfect;
        } else if (weakSelf.onceTime < 600) {
            type = QJLResultStateTypeGreat;
        } else if (weakSelf.onceTime < 700) {
            type = QJLResultStateTypeGood;
        } else {
            type = QJLResultStateTypeOK;
        }
        
        [weakSelf.stateView showStateViewWithType:type stageViewHiddenFinishBlock:^{
            
            if (weakSelf.count == 9) {
                [weakSelf showResultControllerWithNewScroe:weakSelf.allScore / 9 unit:@"ms" stage:weakSelf.stage isAddScore:YES];
            } else {
                [weakSelf.numView setHidden:YES];
                [weakSelf.numView cleanData];
                [weakSelf.peopleView setHidden:YES];
                [(QJLCountTimeView *)weakSelf.countScore cleanData];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (!weakSelf.playAgain) {
                        [weakSelf.busView showBus];
                    }
                });
            }
        }];
    };
}

- (void)buildBottomNumberView {
    self.numView = [[QJLStage10BottomNumView alloc] initWithFrame:CGRectMake(0, self.redButton.frame.origin.y + 4, ScreenWidth, self.redButton.frame.size.height)];
    self.numView.userInteractionEnabled = NO;
    self.numView.hidden = YES;
    [self.view insertSubview:self.numView aboveSubview:self.blueButton];
}

- (void)buildBgImageView {
    UIImageView *bgIV = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bgIV.image = [UIImage imageNamed:@"12_bg-iphone4"];
    [self.view insertSubview:bgIV belowSubview:self.redButton];
}

- (void)buildPeopleView {
    self.peopleView = [[QJLStage23PeopleView alloc] initWithFrame:CGRectMake(0, ScreenHeight - ScreenWidth / 3 - 90, ScreenWidth, 100)];
    self.peopleView.hidden = YES;
    [self.view addSubview:self.peopleView];
}

- (void)showBadView {
    self.view.userInteractionEnabled = NO;
    UIImageView *xIV = [[UIImageView alloc] initWithFrame:CGRectMake(kCountStartX(180), 200, 180, 180)];
    xIV.image = [UIImage imageNamed:@"00_cross-iphone4"];
    [self.view addSubview:xIV];
    
    UIImageView *badIV = [[UIImageView alloc] initWithFrame:CGRectMake(kCountStartX(260) + 130, 0, 260, 142)];
    badIV.layer.anchorPoint = CGPointMake(1, 0.5);
    badIV.center = CGPointMake(badIV.center.x, xIV.center.y);
    badIV.image = [UIImage imageNamed:@"00_bad-iphone4"];
    [self.view addSubview:badIV];
    
    NSString *badName = [NSString stringWithFormat:@"instantFail0%d.mp3", arc4random_uniform(3) + 2];
    [[QJLSoundToolManager sharedSoundToolManager] playSoundWithSoundName:badName];
    
    [self showCorrectBus];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        badIV.transform = CGAffineTransformMakeRotation(-M_PI_4);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showGameFail];
        });
    }];
}

- (void)buildTimeOutView {
    UIImageView *tooShow = [[UIImageView alloc] initWithFrame:CGRectMake(kCountStartX(250), CGRectGetMinY(self.peopleView.frame) - 67, 250, 67)];
    tooShow.image = [UIImage imageNamed:@"09_fraction05-iphone4"];
    [self.view addSubview:tooShow];
    
    [self showCorrectBus];
}

- (void)showCorrectBus {
    [self.busView showCorrectBus];
    [self.view bringSubviewToFront:self.busView];
    self.busView.center = CGPointMake(ScreenWidth * 0.5, self.busView.center.y + 40);
}

#pragma mark - Super Method
- (void)readyGoAnimationFinish {
    [super readyGoAnimationFinish];
    
    [self.view bringSubviewToFront:self.busView];
    [self setButtonsIsActivate:NO];
    [self.busView showBus];
    
    _count = 0;
    self.allScore = 0;
    self.onceTime = 0;
}

#pragma mark - Action
- (void)btnClick:(UIButton *)sender {
    [self.peopleView clickIndex:sender.tag];
    [self.numView addNumWithIndex:(int)sender.tag];
    
    if (![self.busView guessWithIndex:sender.tag]) {
        [(QJLCountTimeView *)self.countScore stopCalculateByTimeWithTimeBlock:nil];
        [self showBadView];
    }
}

- (void)pauseGame {
    [(QJLCountTimeView *)self.countScore pause];
    [self.busView pause];
    
    [super pauseGame];
}

- (void)continueGame {
    [super continueGame];
    
    [self.busView resume];
    [(QJLCountTimeView *)self.countScore continueGame];
}

- (void)playAgainGame {

    [(QJLCountTimeView *)self.countScore cleanData];
    
    [self.peopleView setHidden:YES];
    [self.numView cleanData];
    self.numView.hidden = YES;
    
    [self.busView removeData];
    self.busView = nil;
    [self buildBusView];
    
    _playAgain = YES;
    
    [self.stateView removeData];
    [self buildStageView];
    
    [super playAgainGame];
}

@end
