//
//  QYRecommendTypeViewCell.m
//  百思不得其姐
//
//  Created by lanou on 16/4/7.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYRecommendTypeViewCell.h"

@implementation QYRecommendTypeViewCell

- (void)setTypeModel:(QYRecommendTypeModel *)typeModel {
    _typeModel = typeModel;
    self.textLabel.text = [NSString stringWithFormat:@"%@", typeModel.name];
}

//对控件初始化
- (void)awakeFromNib {
    self.backgroundColor = GlobalColor;
    self.textLabel.textColor = RGBColor(78, 78, 78);
    self.typeView.backgroundColor = RGBColor(219, 21, 26);
    //当cell的selection为None时，即使cell被选中，内部的子控件也不会进入高亮状态
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.textLabel.textColor = selected ? self.typeView.backgroundColor : RGBColor(78, 78, 78);

    self.typeView.hidden = !selected;
//    self.textLabel.textColor
}
//因为底下的白色线被挡住 所以要重构子控件的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.y = 1;
    self.textLabel.height = self.contentView.height - 4;
}

@end
