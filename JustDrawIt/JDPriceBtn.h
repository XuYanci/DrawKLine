//
//  JDPriceBtn.h
//  JustDrawIt
//
//  Created by Yanci on 16/4/3.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDPriceBtn : UIButton {
    NSString *title_;
    NSString *value_;
}

- (void)setTitle:(NSString *)title;
- (void)setValue:(NSString *)value;
@end
