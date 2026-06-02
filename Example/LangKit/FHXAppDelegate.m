//
//  FHXAppDelegate.m
//  LangKit
//
//  Created by fenghanxu on 06/01/2026.
//  Copyright (c) 2026 fenghanxu. All rights reserved.
//

#import "FHXAppDelegate.h"
#import "LangKit.h"

@implementation FHXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self language];
    return YES;
}

-(void)language {
    if (![LangKit localizationDictionaryForTable:@"en"]) {
        NSData *enData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"json"]];
        NSDictionary *enJson = [NSJSONSerialization JSONObjectWithData:enData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:enJson table:@"en" update:NO storeOnDisk:YES];
    }
    
    if (![LangKit localizationDictionaryForTable:@"cn"]) {
        NSData *cnData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cn" ofType:@"json"]];
        NSDictionary *cnJson = [NSJSONSerialization JSONObjectWithData:cnData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:cnJson table:@"cn" update:NO storeOnDisk:YES];
    }
    
    if (![LangKit localizationDictionaryForTable:@"de"]) {
        NSData *deData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"de" ofType:@"json"]];
        NSDictionary *deJson = [NSJSONSerialization JSONObjectWithData:deData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:deJson table:@"de" update:NO storeOnDisk:YES];
    }

    if (![LangKit localizationDictionaryForTable:@"es"]) {
        NSData *esData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"es" ofType:@"json"]];
        NSDictionary *esJson = [NSJSONSerialization JSONObjectWithData:esData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:esJson table:@"es" update:NO storeOnDisk:YES];
    }

    if (![LangKit localizationDictionaryForTable:@"fr"]) {
        NSData *frData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fr" ofType:@"json"]];
        NSDictionary *frJson = [NSJSONSerialization JSONObjectWithData:frData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:frJson table:@"fr" update:NO storeOnDisk:YES];
    }

    if (![LangKit localizationDictionaryForTable:@"ko"]) {
        NSData *koData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ko" ofType:@"json"]];
        NSDictionary *koJson = [NSJSONSerialization JSONObjectWithData:koData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:koJson table:@"ko" update:NO storeOnDisk:YES];
    }

    if (![LangKit localizationDictionaryForTable:@"pt"]) {
        NSData *ptData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pt" ofType:@"json"]];
        NSDictionary *ptJson = [NSJSONSerialization JSONObjectWithData:ptData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:ptJson table:@"pt" update:NO storeOnDisk:YES];
    }

    if (![LangKit localizationDictionaryForTable:@"zh"]) {
        NSData *zhData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zh" ofType:@"json"]];
        NSDictionary *zhJson = [NSJSONSerialization JSONObjectWithData:zhData options:NSJSONReadingMutableContainers error:nil];
        [LangKit setMainLocalizationDictionary:zhJson table:@"zh" update:NO storeOnDisk:YES];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
