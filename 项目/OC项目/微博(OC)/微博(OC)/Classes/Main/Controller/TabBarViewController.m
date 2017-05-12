//
//  TabBarViewController.m
//  微博(OC)
//
//  Created by 金亮齐 on 2017/5/12.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "NavigationController.h"
#import "DiscoverViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置子控制器
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildViewController:home title:@"首页" image:@"tabbar_home" selImage:@"tabbar_home_selected"];
    
    
    MessageViewController *messageCenter = [[MessageViewController alloc] init];
    [self addChildViewController:messageCenter title:@"消息" image:@"tabbar_message_center" selImage:@"tabbar_message_center_selected"];
    
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addChildViewController:discover title:@"发现" image:@"tabbar_discover" selImage:@"tabbar_discover_selected"];
    
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self addChildViewController:profile title:@"我" image:@"tabbar_profile" selImage:@"tabbar_profile_selected"];
    

    // Do any additional setup after loading the view.
}

//添加子控制器
-(void)addChildViewController:(UIViewController *)childVc  title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    
    //设置子控制器的TabBarButton属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *AttrDic = [NSMutableDictionary dictionary];
    
    AttrDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [childVc.tabBarItem setTitleTextAttributes:AttrDic forState:UIControlStateNormal];
    
    NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
    
    selAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:selAttr forState:UIControlStateSelected];
    
    //让子控制器包装一个导航控制器
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}

@end
