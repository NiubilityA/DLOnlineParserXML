//
//  DLOnlineParserNotesXMLManager.m
//  diliuRead
//
//  Created by Char on 2016/12/15.
//  Copyright © 2016年 zhangqi. All rights reserved.
//

#import "DLOnlineParserNotesXMLManager.h"
#import "DLNoteInfomation.h"

@interface DLOnlineParserNotesXMLManager ()<NSXMLParserDelegate>

@property (nonatomic,copy) NSMutableString *elementNameString;
@property (nonatomic,copy) NSMutableArray *elementsArray;
@property (nonatomic,strong) DLNoteInfomation *noteInfomation;
@end

@implementation DLOnlineParserNotesXMLManager

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    _onlineParserNotesXMLSuccessBlock(self.elementsArray);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    NSLog(@"3.发现结束节点 %@",elementName);
    //    NSLog(@"拼接的内容%@",self.elementNameString);

    if ([elementName isEqualToString:@"bookname"]) {
        self.noteInfomation.bookname = self.elementNameString;
    } else if ([elementName isEqualToString:@"bookno"]) {
        self.noteInfomation.bookno = self.elementNameString;
    } else if ([elementName isEqualToString:@"noteno"]) {
        self.noteInfomation.noteno = self.elementNameString;
    } else if ([elementName isEqualToString:@"bookurl"]) {
        self.noteInfomation.bookurl = self.elementNameString;
    } else if ([elementName isEqualToString:@"bookmsg"]) {
        self.noteInfomation.bookmsg = self.elementNameString;
    } else if ([elementName isEqualToString:@"notename"]) {
        self.noteInfomation.notename = self.elementNameString;
    } else if ([elementName isEqualToString:@"schedule"]) {
        self.noteInfomation.schedule = self.elementNameString;
    }  else if ([elementName isEqualToString:@"noteurl"]) {
        self.noteInfomation.noteurl = self.elementNameString;
    } else if ([elementName isEqualToString:@"notemsg"]) {
        self.noteInfomation.notemsg = self.elementNameString;
    } else if ([elementName isEqualToString:@"createtime"]) {
        self.noteInfomation.createtime = self.elementNameString;

    } else if ([elementName isEqualToString:@"list"]) {
        [self.elementsArray addObject:self.noteInfomation];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    NSLog(@"3.发现节点内容：%@",string);
    //把发现的内容进行拼接
    [self.elementNameString appendString:string];
}

/**
 *  每发现一个节点就调用
 *  *  @param parser        解析器
 *  @param elementName   节点名字
 *  @param attributeDict 属性字典
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    NSLog(@"2.发现节点：%@",elementName);
    if ([elementName isEqualToString:@"list"])
    {
        //创建模型对象
        self.noteInfomation = [[DLNoteInfomation alloc]init];
    }

    [self.elementNameString setString:@""];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"1.开始文档");
}

/**
 单例创建对象

 @return 获得单例对象
 */
+ (DLOnlineParserNotesXMLManager *)sharedInstance {

    static DLOnlineParserNotesXMLManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DLOnlineParserNotesXMLManager alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - 懒加载
- (NSMutableString *)elementNameString
{
    if (_elementNameString == nil)
    {
        _elementNameString = [[NSMutableString alloc]init];
    }
    return _elementNameString;
}

#pragma mark - 懒加载
- (NSMutableArray *)elementsArray
{
    if (_elementsArray == nil)
    {
        _elementsArray = [[NSMutableArray alloc]init];
    }
    return _elementsArray;
}

/**
 在线解析 XML 文件

 @param URL  xml 文件所在的地址
 @param successfulCompletion 解析完成的回调
 */
- (void)onlineParserNotesXML:(NSString * _Nullable)URL Completion:(OnlineParserNotesXMLSuccessBlock _Nullable)successfulCompletion {

    _onlineParserNotesXMLSuccessBlock = successfulCompletion;

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:URL] completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                // handle response

        //创建xml解析器
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
        //设置代理
        parser.delegate = self;
        //开始解析
        [parser parse];

     }] resume];
}

/**
 在线解析 XML 文件

 @param URL  xml 文件所在的地址
 @param successfulCompletion 解析完成的回调
 */
+ (void)onlineParserNotesXML:(NSString * _Nullable)URL Completion:(OnlineParserNotesXMLSuccessBlock _Nullable)successfulCompletion {

    [[DLOnlineParserNotesXMLManager sharedInstance] onlineParserNotesXML:URL Completion:successfulCompletion];

}

@end
