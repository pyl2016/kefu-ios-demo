//
//  HNetworkManager.h
//  helpdesk_sdk
//
//  Created by afanda on 16/11/23.
//  Copyright © 2016年 hyphenate. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionBlock)(id responseObject,NSError *error);
@interface HNetworkManager : NSObject

/**
 使用留言功能需要传入IM 服务号
 */

@property(nonatomic,copy) NSString  *imServiceNo;

+(instancetype)shareInstance;

/*
 @method
 @brief 创建一个留言
 @discussion 失败返回NSError,成功返回responseObject
 @param tenantId    客服tenantId
 @param projectId   留言的Project ID
 @param parameters  留言参数
 @result
 */
- (void)asyncCreateMessageWithTenantId:(NSString*)tenantId
                             projectId:(NSString*)projectId
                            parameters:(NSDictionary*)parameters
                            completion:(CompletionBlock)completion;
/*
 @method
 @brief 获取留言详情
 @discussion 失败返回NSError,成功返回responseObject
 @param tenantId    客服tenantId
 @param projectId   留言的Project ID
 @param tickedId    留言ID
 @param parameters  参数
 @result
 */
- (void)asyncGetLeaveMessageDetailWithTenantId:(NSString*)tenantId
                                     projectId:(NSString*)projectId
                                      ticketId:(NSInteger)ticketId
                                    parameters:(NSDictionary*)parameters
                                    completion:(CompletionBlock)completion;

/*
 @method
 @brief 获取留言下所有评论
 @discussion 失败返回NSError,成功返回responseObject
 @param tenantId    客服tenantId
 @param projectId   留言的Project ID
 @param tickedId    留言ID
 @param parameters  参数
 @result
 */
- (void)asyncGetLeaveMessageAllCommentsWithTenantId:(NSString*)tenantId
                                          projectId:(NSString*)projectId
                                           ticketId:(NSInteger)ticketId
                                         parameters:(NSDictionary*)parameters
                                         completion:(CompletionBlock)completion;

/*
 @method
 @brief 给一个留言添加评论
 @discussion 失败返回NSError,成功返回responseObject
 @param tenantId    客服tenantId
 @param projectId   留言的Project ID
 @param tickedId    留言ID
 @param parameters  参数
 @result
 */
- (void)asyncLeaveAMessageWithTenantId:(NSString*)tenantId
                             projectId:(NSString*)projectId
                              ticketId:(NSInteger)ticketId
                            parameters:(NSDictionary*)parameters
                            completion:(CompletionBlock)completion;


/*
 @method
 @brief 获取留言列表
 @discussion 失败返回NSError,成功返回responseObject
 @param tenantId    客服tenantId
 @param projectId   留言的Project ID
 @param parameters  参数
 @result
 */
- (void)asyncGetMessagesWithTenantId:(NSString*)tenantId
                           projectId:(NSString*)projectId
                          parameters:(NSDictionary*)parameters
                          completion:(CompletionBlock)completion;


/*
 @method
 @brief 上传附件
 @discussion 失败返回NSError,成功返回responseObject
 @param tenantId    客服tenantId
 @param file        附件
 @param parameters  参数
 @result
 */
- (void)uploadWithTenantId:(NSString*)tenantId
                      File:(NSData*)file
                parameters:(NSDictionary*)parameters
                completion:(CompletionBlock)completion;

/*
 下载文件
 */

- (void)downloadFileWithUrl:(NSString *)url completionHander:(void (^)(BOOL success,NSURL *filePath,NSError *error))completion;





@end
