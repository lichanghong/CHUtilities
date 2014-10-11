//
//  CHLocationUtil.h
//  CHUtilities
//
//  Created by li on 10/8/14.
//  Copyright (c) 2014 lch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 * @brief 用户是否允许地理定位
 */
#define LOCATIONSERVICE_ENABLED ([CLLocationManager locationServicesEnabled] &&[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)


@interface CHLocationUtil : NSObject

@end
