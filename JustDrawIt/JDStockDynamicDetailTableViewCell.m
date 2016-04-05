//
//  JDStockDynamicDetailTableViewCell.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/3.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDStockDynamicDetailTableViewCell.h"
#import "UIView+Borders.h"
#import "JDPriceBtn.h"
@implementation JDStockDynamicDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // Set price buttons border
    for (JDPriceBtn *btn in _priceBtns) {
        [btn setTitle:@"title"];
        [btn setValue:@"value"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)dingZengXinXiBtnClick:(id)sender {
    
}

@end
