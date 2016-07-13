//
//  MapViewController.m
//  ResCUer
//
//  Created by LiuYang on 7/10/16.
//  Copyright © 2016 LiuYang. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()
@property (nonatomic,strong)  CLGeocoder *geo;
@end

@implementation MapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.geo  geocodeAddressString:@"Current Location" completionHandler:^(NSArray *placemarks, NSError *error) {
        //获取到起点的MKplaceMark
        MKPlacemark *startPlace = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
        //等待获取到起点的placemarks之后在获取终点的placemarks，block回调延迟问题
        [self.geo  geocodeAddressString:@"NYC" completionHandler:^(NSArray *placemarks, NSError *error) {
            /**
             获取到终点的MKplaceMark，MKPlaceMark 是ClPlaceMark的子类。
             */
            MKPlacemark *endPlace = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
            /**
             将MKPlaceMark转换成MKMapItem，这样可以放入到item这个数组中
             */
//            MKMapItem *startItem = [[MKMapItem alloc ] initWithPlacemark:startPlace];
            MKMapItem *startItem = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *endItem = [[MKMapItem alloc ] initWithPlacemark:endPlace];
            NSArray *item = @[startItem ,endItem];
            //建立字典存储导航的相关参数
            NSMutableDictionary *md = [NSMutableDictionary dictionary];
            md[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
            md[MKLaunchOptionsMapTypeKey] = [NSNumber numberWithInteger:MKMapTypeHybrid];
            /**
             *调用app自带导航，需要传入一个数组和一个字典，数组中放入MKMapItem，
             字典中放入对应键值
             
             MKLaunchOptionsDirectionsModeKey   开启导航模式
             MKLaunchOptionsMapTypeKey  地图模式
             MKMapTypeStandard = 0,
             MKMapTypeSatellite,
             MKMapTypeHybrid
             
             // 导航模式
             MKLaunchOptionsDirectionsModeDriving 开车;
             MKLaunchOptionsDirectionsModeWalking 步行;
             */
#warning 其实所有的代码都是为了下面一句话，打开系统自带的高德地图然后执行某些动作，launchOptions里面的参数指定做哪些动作
            [MKMapItem openMapsWithItems:item launchOptions:md];
        }];
    }];
    
}
#pragma mark - 超级懒加载
-(CLGeocoder *)geo
{
    if (!_geo)
    {
        _geo = [[CLGeocoder alloc] init];
        
    }
    return  _geo;
}
@end
