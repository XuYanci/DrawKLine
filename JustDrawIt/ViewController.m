//
//  ViewController.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/2.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "ViewController.h"
#import "MXRequest+WisdomFinancialInformationCloud.h"
#import "UIViewController+MBProgressHUD.h"
#import "AppConfig.h"
#import "NSDictionary+Validation.h"
#import "JDNavigationController.h"
#import "JDStockDetialViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self showHUDWithMessage:@"Getting the token ..."];
    [MXRequest sendTokenRequest:YUNDZH_APPID secretKey:YUNDZH_APPSECRET callback:^(NSInteger error, id result) {
        if (error == 0) {
            [self showHUDWithMessage:@"network error !"];
        }
        else {
            NSDictionary *resultDict = result;
            NSNumber *error = [resultDict numberForKey:@"Err"];
            if (error.intValue == 0) {
                [self hideHUDWithCompletionMessage:@"Token response success !"];
                
                /* Get the reponse token */
                NSDictionary *repDataToken = [[[resultDict dictionaryForKey:@"Data"] arrayForKey:@"RepDataToken"]objectAtIndex:0];
                
                /* Save to userdefault */
                [[NSUserDefaults standardUserDefaults]setObject:repDataToken forKey:@"JD_USERDEFAULT_REPDATATOKEN"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            else {
                [self hideHUDWithCompletionMessage:@"Token response error !"];
            }
        }
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user actions
- (IBAction)StockDemoBtnClick:(id)sender {
    JDStockDetialViewController *stockDetailVC = [[JDStockDetialViewController alloc]init];
    [self.navigationController pushViewController:stockDetailVC animated:TRUE];
}


#pragma mark - getter and setter



@end
