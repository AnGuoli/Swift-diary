//
//  QJLPauseViewController.m
//  Game
//
//  Created by 金亮齐 on 16/7/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

#import "QJLPauseViewController.h"
#import "QJLSettingViewController.h"
#import "UIView+QJLImage.h"
#import "PrefixHeader.pch"
#define kPushDuration 2.5

@interface QJLPauseViewController ()
{
    NSArray *_adImageNames;
    int _index;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageCentX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adImageTop;
@property (weak, nonatomic) IBOutlet UIImageView *idImageView;
@property (weak, nonatomic) IBOutlet UIButton *idButton;

@end

@implementation QJLPauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundImageWihtImageName:@"pause_bg"];
    
    if (!iPhone5) {
        self.adImageTop.constant = 80;
        [self.view setNeedsLayout];
    }
    
    _adImageNames = [NSArray arrayWithObjects:@"ad01", @"ad02", @"ad03", @"ad04", nil];
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(rightWithTag:) userInfo:nil repeats:YES];
}



- (IBAction)buttonClick:(UIButton *)sender {
    [[QJLSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundCliclName];
    switch (sender.tag) {
        case 10:
            [self left];
            break;
        case 11:
            [self rightWithTag:1];
            break;
        case 20:
            [[NSNotificationCenter defaultCenter] postNotificationName:kPauseViewControllerClickBackToMainViewController object:nil];
            [self.navigationController popToRootViewControllerAnimated:NO];
            break;
        case 21:
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            QJLSettingViewController *settingVC = [sb instantiateViewControllerWithIdentifier:@"settingVC"];
            [self.navigationController pushViewController:settingVC animated:NO];
        }
            break;
        case 22:
            [self.navigationController popViewControllerAnimated:NO];
            if (self.ContinueGameButtonClick) {
                self.ContinueGameButtonClick();
            }
            break;
        case 30:
            [self showAD];
            break;
        default:
            break;
    }
}

- (void)showAD {
    switch (_index) {
        case 0:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAuthorSineWeiBoUrlString]];
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAuthorGithubURLString]];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAuthorBlogURLString]];
            break;
        case 3:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAuthorGithubURLString]];
            break;
        default:
            break;
    }
}

- (void)rightWithTag:(int)tag {
    _index++;
    if (_index > 3) {
        _index = 0;
    }
    if (tag == 1) {
        [self changeADImageViewWithDirection:kCATransitionFromRight duration:0.1];
    } else {
        [self changeADImageViewWithDirection:kCATransitionFromRight duration:0];
    }
}

- (void)left {
    _index--;
    if (_index < 0) {
        _index = 3;
    }
    [self changeADImageViewWithDirection:kCATransitionFromLeft duration:0.1];
}

- (void)changeADImageViewWithDirection:(NSString *)direction duration:(CFTimeInterval)duration {
    self.idImageView.image = [UIImage imageNamed:_adImageNames[_index]];
    
    CATransition *tran = [CATransition animation];
    tran.type = @"push";
    tran.subtype = direction;
    if (duration) {
        tran.duration = duration;
    }
    tran.delegate = self;
    [self.idImageView.layer addAnimation:tran forKey:nil];
    
    self.pageCentX.constant = _index * 20.0 - 20;
    [self.view setNeedsLayout];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self adButtonStartAnimation];
}

- (void)adButtonStartAnimation {
    self.idButton.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.idButton.transform = CGAffineTransformMakeTranslation(0, -18);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08 animations:^{
            self.idButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.idButton.transform = CGAffineTransformMakeTranslation(0, -10);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.06 animations:^{
                    self.idButton.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
    }];
}

@end
