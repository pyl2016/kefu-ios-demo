//
//  HFileMessageBody.h
//  helpdesk_sdk
//
//  Created by afnada on 1/3/17.
//  Copyright © 2017 hyphenate. All rights reserved.
//

#import "HMessageBody.h"

/*!
 *  \~chinese
 *  附件下载状态
 *
 *  \~english
 *  Message attachment download status
 */
typedef enum{
    HDownloadStatusDownloading   = 0,  /*! \~chinese 正在下载 \~english Downloading */
    HDownloadStatusSuccessed,          /*! \~chinese 下载成功 \~english Successed */
    HDownloadStatusFailed,             /*! \~chinese 下载失败 \~english Failed */
    HDownloadStatusPending,            /*! \~chinese 准备下载 \~english Pending */
}HDownloadStatus;

/*!
 *  \~chinese
 *  文件消息体
 *
 *  \~english
 *  File message body
 */

@interface HFileMessageBody : HMessageBody
/*!
 *  \~chinese
 *  附件的显示名
 *
 *  \~english
 *  Display name of attachment
 */
@property (nonatomic, copy) NSString *displayName;

/*!
 *  \~chinese
 *  附件的本地路径
 *
 *  \~english
 *  Local path of attachment
 */
@property (nonatomic, copy) NSString *localPath;

/*!
 *  \~chinese
 *  附件在服务器上的路径
 *
 *  \~english
 *  Server path of attachment
 */
@property (nonatomic, copy) NSString *remotePath;

/*!
 *  \~chinese
 *  附件的密钥, 下载附件时需要密匙做校验
 *
 *  \~english
 *  Secret key for downloading the message attachment
 */
@property (nonatomic, copy) NSString *secretKey;

/*!
 *  \~chinese
 *  附件的大小, 以字节为单位
 *
 *  \~english
 *  Length of attachment, in bytes
 */
@property (nonatomic) long long fileLength;

/*!
 *  \~chinese
 *  附件的下载状态
 *
 *  \~english
 *  Download status of attachment
 */
@property (nonatomic) HDownloadStatus downloadStatus;


@property(nonatomic,strong) EMFileMessageBody *fileMessageBody;

/*!
 *  \~chinese
 *  初始化文件消息体
 *
 *  @param aLocalPath   附件本地路径
 *  @param aDisplayName 附件显示名（不包含路径）
 *
 *  @result 消息体实例
 *
 *  \~english
 *   Initialize a file message body instance
 *
 *  @param aLocalPath   Local path of the attachment
 *  @param aDisplayName Display name of the attachment
 *
 *  @result File message body instance
 */
- (instancetype)initWithLocalPath:(NSString *)aLocalPath
                      displayName:(NSString *)aDisplayName;

/*!
 *  \~chinese
 *  初始化文件消息体
 *
 *  @param aData        附件数据
 *  @param aDisplayName 附件显示名（不包含路径）
 *
 *  @result 消息体实例
 *
 *  \~english
 *  Initialize a file message body instance
 *
 *  @param aData        The data of attachment file
 *  @param aDisplayName Display name of the attachment
 *
 *  @result File message body instance
 */
- (instancetype)initWithData:(NSData *)aData
                 displayName:(NSString *)aDisplayName;


@end
