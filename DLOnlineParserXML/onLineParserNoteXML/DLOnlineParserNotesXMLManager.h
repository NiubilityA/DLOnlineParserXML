//
//  DLOnlineParserNotesXMLManager.h
//  diliuRead
//
//  Created by Char on 2016/12/15.
//  Copyright © 2016年 zhangqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLOnlineParserNotesXMLManager : NSObject

typedef void (^OnlineParserNotesXMLSuccessBlock)(NSArray * _Nonnull responseObjects);                //请求成功
@property (copy,nonatomic) OnlineParserNotesXMLSuccessBlock _Nonnull   onlineParserNotesXMLSuccessBlock;

/**
 在线解析 XML 文件

 @param URL  xml 文件所在的地址
 @param successfulCompletion 解析完成的回调
 */
+ (void)onlineParserNotesXML:(NSString * _Nullable)URL Completion:(OnlineParserNotesXMLSuccessBlock _Nullable)successfulCompletion;

@end
