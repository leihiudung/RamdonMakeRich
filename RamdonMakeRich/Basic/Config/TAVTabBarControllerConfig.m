//
//  TAVTabBarControllerConfig.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVTabBarControllerConfig.h"
#import "TAVBasicViewController.h"
#import "TAVTabBarViewController.h"
#import "TAVNavigationViewController.h"

#import "TAVViewModelProtocolImp.h"

#import "TAVHallViewModel.h"
#import "TAVHallViewController.h"

#define TAV_LAZY(object, assignment) (object = object ? : assignment)

@interface TAVTabBarControllerConfig ()
@property (nonatomic, readwrite, strong) TAVTabBarViewController *tabBarController;
@end

@implementation TAVTabBarControllerConfig

- (TAVTabBarViewController *)tabBarController {
    return TAV_LAZY(_tabBarController, ({
        TAVTabBarViewController *controller2 = [[TAVTabBarViewController alloc]init];
        NSArray *controllerArr = [self customerViewControllers];
        [controller2 setViewControllers:controllerArr];
        [self customerTabBarAppearance];
        controller2;
        
    }));
//    return _tabBarController;
}

- (NSArray<TAVBasicViewController *> *)customerViewControllers {
    NSMutableArray *controllerArr = [NSMutableArray array];

    TAVViewModelProtocolImp *viewModelImp = [[TAVViewModelProtocolImp alloc]initViewModelWithModel];
    
    TAVHallViewModel *hallViewModel = [[TAVHallViewModel alloc]initWitnViewModelProtocol:viewModelImp];
    TAVHallViewController *hallController = [[TAVHallViewController alloc]initWithViewModel:hallViewModel];
    hallController.tabBarItem.title = @"财富";
    TAVNavigationViewController *naviController = [[TAVNavigationViewController alloc]initWithRootViewController: hallController];
    
    [controllerArr addObject:naviController];
    
    return controllerArr.copy;
}

- (void)customerTabBarAppearance {
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    [normalAttr setObject:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    
    NSMutableDictionary *selectedAtt = [NSMutableDictionary dictionary];
    [selectedAtt setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAtt forState:UIControlStateSelected];
}
@end
