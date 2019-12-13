//
//  DYLocalSocketClient.m
//  DH_CommonUse
//
//  Created by wangdenghui on 2019/12/10.
//

#import "DYLocalSocketClient.h"
#import <arpa/inet.h>
#import <netdb.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <ifaddrs.h>

@interface DYLocalSocketClient ()

@property (nonatomic, assign) int sock;


@end

@implementation DYLocalSocketClient


- (void)connect {
    NSString *host = [self getIPAddress];
    NSNumber *port = @7070;
    
    // 1，创建socket
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        
        NSLog(@"socket error : %d",sock);
        return;
    }
    // 2,获取ip地址
    // 返回对应于给定主机名的包含主机名字和地址信息的hostent结构指针
    struct hostent *remoteHostEnt = gethostbyname([host UTF8String]);
    if (remoteHostEnt == NULL) {
        
        close(sock);
        NSLog(@"无法解析服务器主机名");
        return;
    }
    //
    struct in_addr *remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
    struct sockaddr_in socketParam;
    socketParam.sin_family = AF_INET;
    socketParam.sin_addr = *remoteInAddr;
    socketParam.sin_port = htons([port intValue]);
    
    // 3，使用connect()函数连接主机
    /*
    * connect函数通常用于客户端简历tcp连接，连接指定地址的主机，函数返回一个int值，-1为失败
    * 第一个参数为socket函数创建的套接字，代表这个套接字要连接指定主机
    * 第二个参数为套接字sock想要连接的主机地址和端口号
    * 第三个参数为主机地址大小
    */
    int con = connect(sock, (struct sockaddr *) &socketParam, sizeof(socketParam));
    if (con == -1) {
        
        close(sock);
        NSLog(@"连接失败");
        return;
    }
    NSLog(@"连接成功");
    self.sock = sock;
    
    // 开启一个子线程用于接收数据
    NSThread *recvThread = [[NSThread alloc] initWithTarget:self selector:@selector(recvData) object:nil];
    [recvThread start];
}

- (void)recvData{

    ssize_t bytesRecv = -1;
    char recvData[32] = "";
    while (1) {
    
        bytesRecv = recv(self.sock, recvData, 32, 0);
        NSLog(@"客户端结束到数据：%zd 数据：%s",bytesRecv,recvData);
        if (bytesRecv == 0) {
            break;
        }
    }
}

- (void)sendData:(NSString *)data {
    // 发送数据
    char sendData[32] = "hello service-------33333";
    ssize_t size_t = send(self.sock, sendData, strlen(sendData), 0);
    NSLog(@"sendData - %zd - 数据：%@",size_t, data);
}

// Get IP Address
- (NSString *)getIPAddress {
 
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    NSLog(@"getIPAddress:%@",address);
        #ifdef DEBUG
             NSLog(@"<<<<--wdh-debug-log-->>>>:[%s][line](%@:%d)", __func__, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__);
             return @"127.0.0.1";
         #endif
    return address;
}


@end
