//
//  HomeViewController.m
//  ResCUer
//
//  Created by LiuYang on 4/11/16.
//  Copyright © 2016 LiuYang. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingsViewController.h"

#define BUTTON_WIDTH 200
#define BUTTON_HEIGHT 50
#define BUTTON_CORNER_RADIUS 6
#define LEFT_ALIGNMENT (VIEW_WIDTH * 0.5 - BUTTON_WIDTH * 0.5)

@interface HomeViewController ()
@property (nonatomic, strong) UIButton *RoCButton;
@property (nonatomic, strong) UIButton *policebutton;
@property (nonatomic, strong) UIButton *showWayButton;
@property (nonatomic, strong) UIButton *settingButton;

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation HomeViewController

#pragma mark - Initializers
/*
- (instancetype)init {
    return nil;
}
 */

#pragma mark - View Settings
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"The size is %.1f, %.1f", VIEW_WIDTH, VIEW_HEIGHT);
    
    [self createButtons];
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:5073124600] forKey:@"phoneNumber"];
    [defaults synchronize];
}

- (void)createButtons {
    // roc button
    CGRect rocFrame = CGRectMake(LEFT_ALIGNMENT, VIEW_HEIGHT*0.2, BUTTON_WIDTH, BUTTON_HEIGHT);
    UIButton *RoCButton = [[UIButton alloc] initWithFrame:rocFrame];
    RoCButton.backgroundColor = [UIColor grayColor];
    [RoCButton setTitle:@"RA on Call" forState:UIControlStateNormal];
    RoCButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    RoCButton.layer.masksToBounds = YES;
    [RoCButton addTarget:self action:@selector(roc) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.RoCButton = RoCButton;
    [self.view addSubview:self.RoCButton];
    
    // police button
    CGRect policeFrame = CGRectMake(LEFT_ALIGNMENT, VIEW_HEIGHT*0.2 + BUTTON_HEIGHT*2, BUTTON_WIDTH, BUTTON_HEIGHT);
    UIButton *policeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    policeButton.frame = policeFrame;
    policeButton.backgroundColor = [UIColor grayColor];
    [policeButton setTitle:@"Call the Police" forState:UIControlStateNormal];
    policeButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    policeButton.layer.masksToBounds = YES;
    [policeButton addTarget:self action:@selector(callPolice) forControlEvents:UIControlEventTouchUpInside];
    
    self.policebutton = policeButton;
    [self.view addSubview:self.policebutton];
    
    // show way button
    CGRect showWayFrame = CGRectMake(LEFT_ALIGNMENT, VIEW_HEIGHT*0.2 + BUTTON_HEIGHT*4, BUTTON_WIDTH, BUTTON_HEIGHT);
    UIButton *showWayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showWayButton.frame = showWayFrame;
    showWayButton.backgroundColor = [UIColor grayColor];
    [showWayButton setTitle:@"Show me way home" forState:UIControlStateNormal];
    showWayButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    showWayButton.layer.masksToBounds = YES;
    [showWayButton addTarget:self action:@selector(showWay) forControlEvents:UIControlEventTouchUpInside];
    
    self.showWayButton = showWayButton;
    [self.view addSubview:self.showWayButton];
    
    // setting button
    CGRect settingFrame = CGRectMake(VIEW_WIDTH - 90, VIEW_HEIGHT - 90, 50, 50);
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = settingFrame;
    settingButton.backgroundColor = [UIColor clearColor];
    UIImage *settingIcon = [UIImage imageNamed:@"Dot"];
    [settingButton setImage:settingIcon forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    
    self.settingButton = settingButton;
    [self.view addSubview:settingButton];
}


#pragma mark - Actions
- (void)roc {
    NSLog(@"RA on call!");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *number = [defaults objectForKey:@"phoneNumber"];
    NSString *phoneStr = [NSString stringWithFormat:@"tel://%@", number];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (void)callPolice {
    NSLog(@"Call the police");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Call the police?" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showWay {
    NSLog(@"Show me the way");
    
    MKPlacemark *mark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(40.7128, -74.0059) addressDictionary:nil];
    MKMapItem *dst = [[MKMapItem alloc] initWithPlacemark:mark];
    dst.name = @"NYC";
    NSArray *items = [[NSArray alloc] initWithObjects:dst, nil];
    NSDictionary *options = [[NSDictionary alloc] initWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsDirectionsModeKey, nil];
    
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

- (void)settings {
    NSLog(@"settings");
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    svc.title = @"Settings";
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:svc];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - Help Functions


#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end