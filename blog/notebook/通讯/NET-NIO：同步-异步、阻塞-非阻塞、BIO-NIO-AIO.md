##### 同步/异步
- 同步调用，就是这个调用结束我要知道结果，不管是成功还是失败
- 异步调用，就是这个调用结束不需要知道结果，结果稍后通知我（回调通知）

##### 阻塞/非阻塞
- 阻塞：调用线程可能会本挂起
- 非阻塞：调用不会被挂起

##### 这段话比较清楚 

> “一个IO操作其实分成了两个步骤：发起IO请求和实际的IO操作。 
同步IO和异步IO的区别就在于第二个步骤是否阻塞，如果实际的IO读写阻塞请求进程，那么就是同步IO。 
阻塞IO和非阻塞IO的区别在于第一步，发起IO请求是否会被阻塞，如果阻塞直到完成那么就是传统的阻塞IO，如果不阻塞，那么就是非阻塞IO。 

> 同步和异步是针对应用程序和内核的交互而言的，同步指的是用户进程触发IO操作并等待或者轮询的去查看IO操作是否就绪，而异步是指用户进程触发IO操作以后便开始做自己的事情，而当IO操作已经完成的时候会得到IO完成的通知。而阻塞和非阻塞是针对于进程在访问数据的时候，根据IO操作的就绪状态来采取的不同方式，说白了是一种读取或者写入操作函数的实现方式，阻塞方式下读取或者写入函数将一直等待，而非阻塞方式下，读取或者写入函数会立即返回一个状态值。 

> 所以,IO操作可以分为3类：同步阻塞（即早期的IO操作）、同步非阻塞（NIO）、异步（AIO）。 

- **同步阻塞**：在此种方式下，用户进程在发起一个IO操作以后，必须等待IO操作的完成，只有当真正完成了IO操作以后，用户进程才能运行。JAVA传统的IO模型属于此种方式。 
- **同步非阻塞**：在此种方式下，用户进程发起一个IO操作以后边可返回做其它事情，但是用户进程需要时不时的询问IO操作是否就绪，这就要求用户进程不停的去询问，从而引入不必要的CPU资源浪费。其中目前JAVA的NIO就属于同步非阻塞IO。 
- **异步**：此种方式下是指应用发起一个IO操作以后，不等待内核IO操作的完成，等内核完成IO操作以后会通知应用程序。


##### BIO/NIO/AIO 
    以Java的角度理解：
    BIO，同步阻塞式IO，简单理解：一个连接一个线程
    NIO，同步非阻塞IO，简单理解：一个请求一个线程
    AIO，异步非阻塞IO，简单理解：一个有效请求一个线程

- **Java BIO（同步并阻塞）**：

同步并阻塞，服务器实现模式为一个连接一个线程，即客户端有连接请求时服务器端就需要启动一个线程进行处理，如果这个连接不做任何事情会造成不必要的线程开销，当然可以通过线程池机制改善。

BIO方式适用于连接数目比较小且固定的架构，这种方式对服务器资源要求比较高，并发局限于应用中，JDK1.4以前的唯一选择，但程序直观简单易理解。

在JDK1.4之前，用Java编写网络请求，都是建立一个ServerSocket，然后，客户端建立Socket时就会询问是否有线程可以处理，如果没有，要么等待，要么被拒绝。即：一个连接，要求Server对应一个处理线程。

- **Java NIO（同步非阻）**：

同步非阻塞，服务器实现模式为一个请求一个线程，即客户端发送的连接请求都会注册到多路复用器上，多路复用器轮询到连接有I/O请求时才启动一个线程进行处理。

NIO方式适用于连接数目多且连接比较短（轻操作）的架构，比如聊天服务器，并发局限于应用中，编程比较复杂，JDK1.4开始支持。


在Java里的由来，在JDK1.4及以后版本中提供了一套API来专门操作非阻塞I/O，我们可以在java.nio包及其子包中找到相关的类和接口。由于这套API是JDK新提供的I/O API，因此，也叫New I/O，这就是包名nio的由来。这套API由三个主要的部分组成：缓冲区（Buffers）、通道（Channels）和非阻塞I/O的核心类组成。在理解NIO的时候，需要区分，说的是New I/O还是非阻塞IO,New I/O是Java的包，NIO是非阻塞IO概念。这里讲的是后面一种。

NIO本身是基于事件驱动思想来完成的，其主要想解决的是BIO的大并发问题： 在使用同步I/O的网络应用中，如果要同时处理多个客户端请求，或是在客户端要同时和多个服务器进行通讯，就必须使用多线程来处理。也就是说，将每一个客户端请求分配给一个线程来单独处理。这样做虽然可以达到我们的要求，但同时又会带来另外一个问题。由于每创建一个线程，就要为这个线程分配一定的内存空间（也叫工作存储器），而且操作系统本身也对线程的总数有一定的限制。如果客户端的请求过多，服务端程序可能会因为不堪重负而拒绝客户端的请求，甚至服务器可能会因此而瘫痪。

NIO基于Reactor，当socket有流可读或可写入socket时，操作系统会相应的通知引用程序进行处理，应用再将流读取到缓冲区或写入操作系统。 
也就是说，这个时候，已经不是一个连接就要对应一个处理线程了，而是有效的请求，对应一个线程，当连接没有数据时，是没有工作线程来处理的。

- **Java AIO(NIO.2)（异步非阻）**：

异步非阻塞，服务器实现模式为一个有效请求一个线程，客户端的I/O请求都是由OS先完成了再通知服务器应用去启动线程进行处理。

AIO方式使用于连接数目多且连接比较长（重操作）的架构，比如相册服务器，充分调用OS参与并发操作，编程比较复杂，JDK7开始支持。

与NIO不同，当进行读写操作时，只须直接调用API的read或write方法即可。这两种方法均为异步的，对于读操作而言，当有流可读取时，操作系统会将可读的流传入read方法的缓冲区，并通知应用程序；对于写操作而言，当操作系统将write方法传递的流写入完毕时，操作系统主动通知应用程序。 
即可以理解为，read/write方法都是异步的，完成后会主动调用回调函数。 
在JDK1.7中，这部分内容被称作NIO.2，主要在java.nio.channels包下增加了下面四个异步通道：

    AsynchronousSocketChannel
    AsynchronousServerSocketChannel
    AsynchronousFileChannel
    AsynchronousDatagramChannel
其中的read/write方法，会返回一个带回调函数的对象，当执行完读取/写入操作后，直接调用回调函数。

**另外：** I/O属于底层操作，需要操作系统支持，并发也需要操作系统的支持，所以性能方面不同操作系统差异会比较明显。

[参考1-BIO/NIO/AIO](http://stevex.blog.51cto.com/4300375/1284437)   
[参考2-BIO/NIO/AIO](http://www.cnblogs.com/davidwang456/p/3521343.html)
[Java NIO的bug以及修复](http://www.tuicool.com/articles/mUFnqeM)