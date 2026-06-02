//
//  HomeViewController.m
//  Frame
//
//  Created by 冯汉栩 on 2024/2/4.
//

#import "HomeViewController.h"
#import "LangKit.h"

@interface HomeViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [UILabel new];
    [self.view addSubview:self.titleLabel];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100]
    ]];
    
    self.titleLabel.text = [LangKit stringFor:@"message" table:@"en"];
}

@end
