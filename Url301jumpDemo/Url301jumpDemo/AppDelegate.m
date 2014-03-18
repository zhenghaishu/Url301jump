//
//  AppDelegate.m
//  Url301jumpDemo
//
//  Created by zhenghaishu on 14-3-18.
//  Copyright (c) 2014年 zhenghaishu. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // This url is valid for some hours, please replace it with your own url
    NSString *szUrl = @"http://f.youku.com/player/getFlvPath/sid/139512528867358_01/st/mp4/fileid/030020010050DD8226BA6B03BAF2B113C3430E-D661-DE5C-63D5-2311D0B14B8C?K=457828465c036905261d910a&hd=0&ts=2794&ctype=40";
    NSURL *url = [NSURL URLWithString:szUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    
    return YES;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    NSURLRequest *redirectedRequest = request;
    if (response)
    {
        redirectedRequest = nil;
    }
    
    return redirectedRequest;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *responseDictionary = [httpResponse allHeaderFields];
    NSLog(@"responseDictionary: %@", responseDictionary);
    
    NSString *strNewURLLocation = [responseDictionary objectForKey:@"Location"];
    
    [[NSUserDefaults standardUserDefaults] setObject:strNewURLLocation forKey:@"serverurl"];
    NSString *jumpUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverurl"];
    NSLog(@"Url after 301 jump: %@", jumpUrl);
}

@end
