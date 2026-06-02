//
//  FHXViewController.m
//  LangKit
//
//  Created by fenghanxu on 06/01/2026.
//  Copyright (c) 2026 fenghanxu. All rights reserved.
//

#import "FHXViewController.h"
#import "HomeViewController.h"
#import "LangKit.h"

@interface FHXViewController ()

@property (nonatomic, strong) UIButton *getButton;
@property (nonatomic, strong) UIButton *clearnButton;
@property (nonatomic, strong) UILabel *enLabel;
@property (nonatomic, strong) UILabel *cnLabel;
@property (nonatomic, strong) UILabel *deLabel;
@property (nonatomic, strong) UILabel *esLabel;
@property (nonatomic, strong) UILabel *frLabel;
@property (nonatomic, strong) UILabel *koLabel;
@property (nonatomic, strong) UILabel *ptLabel;
@property (nonatomic, strong) UILabel *zhLabel;

@end

@implementation FHXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    NSURL *url = [NSURL URLWithString:@"https://myserver.com/translations.json"];
    [LangKit downloadLocalizationDictionaryWithURL:url table:nil];

#pragma mark - Get Button

    self.getButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.getButton];

    [self.getButton setTitle:[LangKit stringFor:@"greeting" table:@"en"]
                    forState:UIControlStateNormal];
    [self.getButton setTitleColor:[UIColor grayColor]
                         forState:UIControlStateNormal];
    self.getButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.getButton.layer.cornerRadius = 8.0;
    self.getButton.layer.borderWidth = 2;
    self.getButton.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.getButton addTarget:self
                       action:@selector(getButtonClick)
             forControlEvents:UIControlEventTouchUpInside];

    self.getButton.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.getButton.widthAnchor constraintEqualToConstant:150],
        [self.getButton.heightAnchor constraintEqualToConstant:100],
        [self.getButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:60],
        [self.getButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];

#pragma mark - Clear Button

    self.clearnButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.clearnButton];

    [self.clearnButton setTitle:@"Push HomeVC"
                       forState:UIControlStateNormal];
    [self.clearnButton setTitleColor:[UIColor grayColor]
                            forState:UIControlStateNormal];
    self.clearnButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.clearnButton.layer.cornerRadius = 8.0;
    self.clearnButton.layer.borderWidth = 2;
    self.clearnButton.layer.borderColor = [UIColor grayColor].CGColor;

    [self.clearnButton addTarget:self
                          action:@selector(clearnButtonClick)
                forControlEvents:UIControlEventTouchUpInside];

    self.clearnButton.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.clearnButton.widthAnchor constraintEqualToConstant:150],
        [self.clearnButton.heightAnchor constraintEqualToConstant:100],
        [self.clearnButton.topAnchor constraintEqualToAnchor:self.getButton.bottomAnchor constant:20],
        [self.clearnButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];

#pragma mark - EN

    self.enLabel = [[UILabel alloc] init];
    [self.view addSubview:self.enLabel];

    self.enLabel.text = [LangKit stringFor:@"message" table:@"en"];
    self.enLabel.textColor = [UIColor blackColor];
    self.enLabel.font = [UIFont systemFontOfSize:14];

    self.enLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.enLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.enLabel.topAnchor constraintEqualToAnchor:self.clearnButton.bottomAnchor constant:20]
    ]];

#pragma mark - CN

    self.cnLabel = [[UILabel alloc] init];
    [self.view addSubview:self.cnLabel];

    self.cnLabel.text = [LangKit stringFor:@"message" table:@"cn"];
    self.cnLabel.textColor = [UIColor blackColor];
    self.cnLabel.font = [UIFont systemFontOfSize:14];

    self.cnLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.cnLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.cnLabel.topAnchor constraintEqualToAnchor:self.enLabel.bottomAnchor constant:20]
    ]];

#pragma mark - DE

    self.deLabel = [[UILabel alloc] init];
    [self.view addSubview:self.deLabel];

    self.deLabel.text = [LangKit stringFor:@"message" table:@"de"];
    self.deLabel.textColor = [UIColor blackColor];
    self.deLabel.font = [UIFont systemFontOfSize:14];

    self.deLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.deLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.deLabel.topAnchor constraintEqualToAnchor:self.cnLabel.bottomAnchor constant:20]
    ]];

#pragma mark - ES

    self.esLabel = [[UILabel alloc] init];
    [self.view addSubview:self.esLabel];

    self.esLabel.text = [LangKit stringFor:@"message" table:@"es"];
    self.esLabel.textColor = [UIColor blackColor];
    self.esLabel.font = [UIFont systemFontOfSize:14];

    self.esLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.esLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.esLabel.topAnchor constraintEqualToAnchor:self.deLabel.bottomAnchor constant:20]
    ]];

#pragma mark - FR

    self.frLabel = [[UILabel alloc] init];
    [self.view addSubview:self.frLabel];

    self.frLabel.text = [LangKit stringFor:@"message" table:@"fr"];
    self.frLabel.textColor = [UIColor blackColor];
    self.frLabel.font = [UIFont systemFontOfSize:14];

    self.frLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.frLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.frLabel.topAnchor constraintEqualToAnchor:self.esLabel.bottomAnchor constant:20]
    ]];

#pragma mark - KO

    self.koLabel = [[UILabel alloc] init];
    [self.view addSubview:self.koLabel];

    self.koLabel.text = [LangKit stringFor:@"message" table:@"ko"];
    self.koLabel.textColor = [UIColor blackColor];
    self.koLabel.font = [UIFont systemFontOfSize:14];

    self.koLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.koLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.koLabel.topAnchor constraintEqualToAnchor:self.frLabel.bottomAnchor constant:20]
    ]];

#pragma mark - PT

    self.ptLabel = [[UILabel alloc] init];
    [self.view addSubview:self.ptLabel];

    self.ptLabel.text = [LangKit stringFor:@"message" table:@"pt"];
    self.ptLabel.textColor = [UIColor blackColor];
    self.ptLabel.font = [UIFont systemFontOfSize:14];

    self.ptLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.ptLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.ptLabel.topAnchor constraintEqualToAnchor:self.koLabel.bottomAnchor constant:20]
    ]];

#pragma mark - ZH

    self.zhLabel = [[UILabel alloc] init];
    [self.view addSubview:self.zhLabel];

    self.zhLabel.text = [LangKit stringFor:@"message" table:@"zh"];
    self.zhLabel.textColor = [UIColor blackColor];
    self.zhLabel.font = [UIFont systemFontOfSize:14];

    self.zhLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [self.zhLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.zhLabel.topAnchor constraintEqualToAnchor:self.ptLabel.bottomAnchor constant:20]
    ]];
}

#pragma mark - Actions

- (void)getButtonClick {

    NSData *enData =
    [NSData dataWithContentsOfFile:
     [[NSBundle mainBundle] pathForResource:@"updateEn"
                                     ofType:@"json"]];

    NSDictionary *enJson =
    [NSJSONSerialization JSONObjectWithData:enData
                                    options:NSJSONReadingMutableContainers
                                      error:nil];

    [LangKit setMainLocalizationDictionary:enJson
                                     table:@"en"
                                    update:YES
                               storeOnDisk:YES];

    self.enLabel.text = [LangKit stringFor:@"message" table:@"en"];
}

- (void)clearnButtonClick {

    [self.navigationController pushViewController:[HomeViewController new]
                                         animated:YES];
}

@end
