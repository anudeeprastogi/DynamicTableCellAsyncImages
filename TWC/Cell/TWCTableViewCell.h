//
//  TWCTableViewCell.h
//  TWC
//
//  Created by Anudeep Rastogi on 9/9/15.
//  Copyright (c) 2015 Anudeep Rastogi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWCTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailTxtLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
