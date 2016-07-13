//
//  SettingsViewController.m
//  ResCUer
//
//  Created by LiuYang on 4/29/16.
//  Copyright © 2016 LiuYang. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIView+UIViewAccessory.h"

#define VIEW_WIDTH (self.view.frame.size.width)
#define VIEW_HEIGHT (self.view.frame.size.height)

#define BUTTON_WIDTH 200
#define BUTTON_HEIGHT 50

#define NAVIGATION_HEIGHT self.navigationController.navigationBar.frame.size.height

#define LABEL_WIDTH (VIEW_WIDTH * 0.8)
#define LABEL_HEIGHT (VIEW_HEIGHT * 0.08)
#define V_DISTANCE (VIEW_HEIGHT * 0.01)

#define COMPONENT_BACKGROUND ([UIColor clearColor])

#define TEXT_HEIGHT 60

#define BUTTON_CORNER_RADIUS 6
//#define LEFT_ALIGNMENT (VIEW_WIDTH * 0.7)

@interface SettingsViewController ()

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextField *phoneField;

@property (nonatomic, strong) UILabel *homeLabel;
@property (nonatomic, strong) UITextField *homeField;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation SettingsViewController

#pragma mark - Initializers

//- (instancetype)init {
//    self = [super init];
//    
//    return self;
//}


#pragma mark - View Settings
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Settings";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationController.navigationBar.barTintColor = NAVIGATION_COLOR;
    
    [self createComponents];
    [self setConstraints];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainTap)];
    [self.view addGestureRecognizer:self.tapRecognizer];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // set necessary infos
    [[NSUserDefaults standardUserDefaults] setObject:TAXI_NUMBER forKey:@"taxiNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:POLICE_NUMBER forKey:@"policeNumber"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = BACKGROUND_COLOR;
}

#pragma mark - Actions

- (void)cancelEdit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    // check if all numbers
    NSLog(@"%ld", [self.phoneField.text integerValue]);
    if ([self onlyNumberIn:self.phoneField.text]) {
        [[NSUserDefaults standardUserDefaults] setObject:self.phoneField.text forKey:PHONE_NUMBER];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        // assume >= iOS 9.0
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                       message:@"Number only"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)mainTap {
    NSLog(@"tap");
    [self.phoneField endEditing:YES];
}

#pragma mark - Constraints
- (void)createComponents {
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneLabel.text = @"Please set the phone number you want to call";
    self.phoneLabel.textColor = [UIColor whiteColor];
    self.phoneLabel.adjustsFontSizeToFitWidth = YES;
    self.phoneLabel.numberOfLines = 0;
    self.phoneLabel.backgroundColor = COMPONENT_BACKGROUND;
    [self.view addSubview:self.phoneLabel];
    
    self.phoneField = [[UITextField alloc] init];
    self.phoneField.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneField.delegate = self;
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Phone Number"
                                                                            attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.phoneField.textColor = [UIColor whiteColor];
    self.phoneField.adjustsFontSizeToFitWidth = YES;
    self.phoneField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.phoneField.borderStyle = UITextBorderStyleNone;
    self.phoneField.backgroundColor = COMPONENT_BACKGROUND;
    [self.view addSubview:self.phoneField];
    
    self.homeLabel = [[UILabel alloc] init];
    self.homeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.homeLabel.text = @"Enter the home address below";
    self.homeLabel.textColor = [UIColor whiteColor];
    self.homeLabel.adjustsFontSizeToFitWidth = YES;
    self.homeLabel.numberOfLines = 0;
    self.homeLabel.backgroundColor = COMPONENT_BACKGROUND;
    [self.view addSubview:self.homeLabel];
    
    self.homeField = [[UITextField alloc] init];
    self.homeField.translatesAutoresizingMaskIntoConstraints = NO;
    self.homeField.backgroundColor = [UIColor clearColor];
    self.homeField.delegate = self;
    self.homeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Home Address"
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.homeField.textColor = [UIColor whiteColor];
    self.homeField.adjustsFontSizeToFitWidth = YES;
    self.homeField.keyboardType = UIKeyboardTypeAlphabet;
    self.homeField.borderStyle = UITextBorderStyleNone;
    self.homeField.backgroundColor = COMPONENT_BACKGROUND;
    [self.view addSubview:self.homeField];
}

- (void)setConstraints {
    NSDictionary *viewsDictionary = @{@"navBar":self.navigationController.navigationBar,
                                      @"phoneLabel":self.phoneLabel,
                                      @"phoneText":self.phoneField,
                                      @"homeLabel":self.homeLabel,
                                      @"homeText":self.homeField};
    
    // phoneLabel constraint
    NSDictionary *phoneLabelMetrics = @{@"labelWidth":@LABEL_WIDTH,
                                        @"topDist":@(30+NAVIGATION_HEIGHT),
                                        @"labelHeight":@LABEL_HEIGHT};
    
    NSMutableArray *phoneLabelConstrains = [[NSMutableArray alloc] init];
    
    [phoneLabelConstrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[phoneLabel(labelHeight)]"
                                                                            options:0
                                                                            metrics:phoneLabelMetrics
                                                                              views:viewsDictionary]];
    [phoneLabelConstrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[phoneLabel(labelWidth)]"
                                                                            options:0
                                                                            metrics:phoneLabelMetrics
                                                                              views:viewsDictionary]];
    [phoneLabelConstrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topDist)-[phoneLabel]"
                                                                            options:0
                                                                            metrics:phoneLabelMetrics
                                                                              views:viewsDictionary]];
    [phoneLabelConstrains addObject:[NSLayoutConstraint constraintWithItem:self.phoneLabel
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.0f
                                                                  constant:0.0f]];
    [NSLayoutConstraint activateConstraints:phoneLabelConstrains];
    
    // phoneText constraints
    NSDictionary *phoneTextMetrics = @{@"textWidth":@LABEL_WIDTH,
                                       @"textHeight":@BUTTON_HEIGHT,
//                                       @"disFromPhoneLabel":@30};
                                       @"disFromPhoneLabel":@V_DISTANCE};
    NSMutableArray *phoneTextConstrains = [[NSMutableArray alloc] init];
    [phoneTextConstrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[phoneLabel]-(disFromPhoneLabel)-[phoneText]"
                                                                           options:0
                                                                           metrics:phoneTextMetrics
                                                                             views:viewsDictionary]];
    [phoneTextConstrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[phoneText(textWidth)]"
                                                                           options:0
                                                                           metrics:phoneTextMetrics
                                                                             views:viewsDictionary]];
    [phoneTextConstrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[phoneText(textHeight)]"
                                                                           options:0
                                                                           metrics:phoneTextMetrics
                                                                             views:viewsDictionary]];
    [phoneTextConstrains addObject:[NSLayoutConstraint constraintWithItem:self.phoneField
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1.0f
                                                                 constant:0.0f]];
    [NSLayoutConstraint activateConstraints:phoneTextConstrains];
    [self.phoneField addUnderLine]; // why???????????
    
    // homeLabel constraints
//    NSDictionary *homeLabelMetrics = @{@"disFromPhoneText":@30};
    NSDictionary *homeLabelMetrics = @{@"disFromPhoneText":@V_DISTANCE};
    NSMutableArray *homeLabelConstraints = [[NSMutableArray alloc] init];
    [homeLabelConstraints addObject:[NSLayoutConstraint constraintWithItem:self.homeLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.phoneLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:1.0f
                                                                  constant:0.0f]];
    [homeLabelConstraints addObject:[NSLayoutConstraint constraintWithItem:self.homeLabel
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.phoneLabel
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:1.0f
                                                                  constant:0.0f]];
    [homeLabelConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[phoneText]-(disFromPhoneText)-[homeLabel]"
                                                                            options:0
                                                                            metrics:homeLabelMetrics
                                                                              views:viewsDictionary]];
    [homeLabelConstraints addObject:[NSLayoutConstraint constraintWithItem:self.homeLabel
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.0f
                                                                  constant:0.0f]];
    [NSLayoutConstraint activateConstraints:homeLabelConstraints];
    
    // homeText constraints
    NSDictionary *homeTextMetrics = @{@"disFromHomeLabel":@V_DISTANCE};
    NSMutableArray *homeTextConstraints = [[NSMutableArray alloc] init];
    [homeTextConstraints addObject:[NSLayoutConstraint constraintWithItem:self.homeField
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.phoneField
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0f
                                                                 constant:0.0f]];
    [homeTextConstraints addObject:[NSLayoutConstraint constraintWithItem:self.homeField
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.phoneField
                                                                attribute:NSLayoutAttributeHeight
                                                               multiplier:1.0f
                                                                 constant:0.0f]];
    [homeTextConstraints addObject:[NSLayoutConstraint constraintWithItem:self.homeField
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1.0f
                                                                 constant:0.0f]];
    [homeTextConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[homeLabel]-(disFromHomeLabel)-[homeText]"
                                                                           options:0
                                                                           metrics:homeTextMetrics
                                                                             views:viewsDictionary]];
    [NSLayoutConstraint activateConstraints:homeTextConstraints];
    [self.homeField addUnderLine];
}

#pragma mark - Help Functions

- (BOOL)onlyNumberIn:(NSString *)string {
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) return NO;
    return YES;
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    NSLog(@"end editing");
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"end editing");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:[textField.text intValue]] forKey:@"phoneNumber"];
    [textField endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}


@end

