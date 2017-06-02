@[Link(ldflags: "build/udtc.o")]
lib LibUDT
  type SYSSOCKET = LibC::Int
  type UDPSOCKET = LibC::Int
  type UDTSOCKET = LibC::Int

  enum UDT_UDTSTATUS
	UDT_INIT = 1
	UDT_OPENED
	UDT_LISTENING
	UDT_CONNECTING
	UDT_CONNECTED
	UDT_BROKEN
	UDT_CLOSING
	UDT_CLOSED
	UDT_NONEXIST
  end

  enum UDT_UDTOpt
	UDT_UDT_MSS              # the Maximum Transfer Unit
	UDT_UDT_SNDSYN           # if sending is blocking
	UDT_UDT_RCVSYN           # if receiving is blocking
	UDT_UDT_CC               # custom congestion control algorithm
	UDT_UDT_FC               # Flight flag size (window size)
	UDT_UDT_SNDBUF           # maximum buffer in sending queue
	UDT_UDT_RCVBUF           # UDT receiving buffer size
	UDT_UDT_LINGER           # waiting for unsent data when closing
	UDT_UDP_SNDBUF           # UDP sending buffer size
	UDT_UDP_RCVBUF           # UDP receiving buffer size
	UDT_UDT_MAXMSG           # maximum datagram message size
	UDT_UDT_MSGTTL           # time-to-live of a datagram message
	UDT_UDT_RENDEZVOUS       # rendezvous connection mode
	UDT_UDT_SNDTIMEO         # send() timeout
	UDT_UDT_RCVTIMEO         # recv() timeout
	UDT_UDT_REUSEADDR        # reuse an existing port or
                                 # create a new one
	UDT_UDT_MAXBW            # maximum bandwidth (bytes per second)
                                 # that the connection can use
	UDT_UDT_STATE            # current socket state, see UDTSTATUS,
                                 # read only
	UDT_UDT_EVENT            # current available events associated
                                 # with the socket
	UDT_UDT_SNDDATA          # size of data in the sending buffer
	UDT_UDT_RCVDATA          # size of data available for recv
  end

  enum UDT_ERRNO
    UDT_SUCCESS = 0
    UDT_ECONNSETUP = 1000
    UDT_ENOSERVER = 1001
    UDT_ECONNREJ = 1002
    UDT_ESOCKFAIL = 1003
    UDT_ESECFAIL = 1004
    UDT_ECONNFAIL = 2000
    UDT_ECONNLOST = 2001
    UDT_ENOCONN = 2002
    UDT_ERESOURCE = 3000
    UDT_ETHREAD = 3001
    UDT_ENOBUF = 3002
    UDT_EFILE = 4000
    UDT_EINVRDOFF = 4001
    UDT_ERDPERM = 4002
    UDT_EINVWROFF = 4003
    UDT_EWRPERM = 4004
    UDT_EINVOP = 5000
    UDT_EBOUNDSOCK = 5001
    UDT_ECONNSOCK = 5002
    UDT_EINVPARAM = 5003
    UDT_EINVSOCK = 5004
    UDT_EUNBOUNDSOCK = 5005
    UDT_ENOLISTEN = 5006
    UDT_ERDVNOSERV = 5007
    UDT_ERDVUNBOUND = 5008
    UDT_ESTREAMILL = 5009
    UDT_EDGRAMILL = 5010
    UDT_EDUPLISTEN = 5011
    UDT_ELARGEMSG = 5012
    UDT_EINVPOLLID = 5013
    UDT_EASYNCFAIL = 6000
    UDT_EASYNCSND = 6001
    UDT_EASYNCRCV = 6002
    UDT_ETIMEOUT = 6003
    UDT_EPEERERR = 7000
    UDT_EUNKNOWN = -1
  end

  struct UDT_CPerfMon_
    # global measurements
    msTimeStamp  : Int64         # time since the UDT entity is started, in milliseconds
    pktSentTotal : Int64         # total number of sent data packets, including retransmissions
    pktRecvTotal : Int64         # total number of received packets
    pktSndLossTotal : LibC::Int  # total number of lost packets (sender side)
    pktRcvLossTotal : LibC::Int  # total number of lost packets (receiver side)
    pktRetransTotal : LibC::Int  # total number of retransmitted packets
    pktSentACKTotal : LibC::Int  # total number of sent ACK packets
    pktRecvACKTotal : LibC::Int  # total number of received ACK packets
    pktSentNAKTotal : LibC::Int  # total number of sent NAK packets
    pktRecvNAKTotal : LibC::Int  # total number of received NAK packets
    usSndDurationTotal : Int64   # total time duration when UDT is sending data (idle time exclusive)

    # local measurements
    pktSent : Int64                     # number of sent data packets, including retransmissions
    pktRecv : Int64                     # number of received packets
    pktSndLoss : LibC::Int                     # number of lost packets (sender side)
    pktRcvLoss : LibC::Int                     # number of lost packets (receiver side)
    pktRetrans : LibC::Int                     # number of retransmitted packets
    pktSentACK : LibC::Int                     # number of sent ACK packets
    pktRecvACK : LibC::Int                     # number of received ACK packets
    pktSentNAK : LibC::Int                     # number of sent NAK packets
    pktRecvNAK : LibC::Int                     # number of received NAK packets
    mbpsSendRate : LibC::Double                 # sending rate in Mb/s
    mbpsRecvRate : LibC::Double                 # receiving rate in Mb/s
    usSndDuration : Int64               # busy sending time (i.e., idle time exclusive)

    # instant measurements
    usPktSndPeriod : LibC::Double               # packet sending period, in microseconds
    pktFlowWindow : LibC::Int                   # flow window size, in number of packets
    pktCongestionWindow : LibC::Int             # congestion window size, in number of packets
    pktFlightSize : LibC::Int                   # number of packets on flight
    msRTT : LibC::Double                        # RTT, in milliseconds
    mbpsBandwidth : LibC::Double                # estimated bandwidth, in Mb/s
    byteAvailSndBuf : LibC::Int                 # available UDT sender buffer size
    byteAvailRcvBuf : LibC::Int                 # available UDT receiver buffer size
  end

  alias UDT_TRACEINFO = UDT_CPerfMon_

  # ???
  # extern const UDTSOCKET UDT_INVALID_SOCK;
  # extern const int UDT_ERROR;

  fun udt_startup() : LibC::Int
  fun udt_cleanup() : LibC::Int

  fun udt_socket(af : LibC::Int, type : LibC::Int, protocol : LibC::Int) : UDTSOCKET
  fun udt_bind(u : UDTSOCKET, name : Pointer(LibC::Sockaddr), namelen : LibC::Int) : LibC::Int
  fun udt_bind2(u : UDTSOCKET, udpsock : UDPSOCKET) : LibC::Int
  fun udt_listen(u : UDTSOCKET, backlog : LibC::Int) : LibC::Int
  fun udt_accept(u : UDTSOCKET, addr : Pointer(LibC::Sockaddr), addrlen : Pointer(LibC::Int)) : UDTSOCKET
  fun udt_connect(u : UDTSOCKET, addr : Pointer(LibC::Sockaddr), namelen : LibC::Int) : LibC::Int
  fun udt_close(u : UDTSOCKET) : LibC::Int
  fun udt_getpeername(u : UDTSOCKET, name : Pointer(LibC::Sockaddr), namelen : Pointer(LibC::Int)) : LibC::Int
  fun udt_getsockname(u : UDTSOCKET, name : Pointer(LibC::Sockaddr), namelen : Pointer(LibC::Int)) : LibC::Int
  fun udt_getsockopt(u : UDTSOCKET, level : LibC::Int, optname : LibC::Int, optval : Pointer(Void), optlen : Pointer(LibC::Int)) : LibC::Int
  fun udt_setsockopt(u : UDTSOCKET, level : LibC::Int, optname : LibC::Int, optval : Pointer(Void), optlen : LibC::Int) : LibC::Int
  fun udt_send(u : UDTSOCKET, buf : Pointer(LibC::Char), len : LibC::Int, flags : LibC::Int) : LibC::Int
  fun udt_recv(u : UDTSOCKET, buf : Pointer(LibC::Char), len : LibC::Int, flags : LibC::Int) : LibC::Int
  fun udt_sendmsg(u : UDTSOCKET, buf : Pointer(LibC::Char), len : LibC::Int, ttl : LibC::Int, inorder : LibC::Int)
  fun udt_recvmsg(u : UDTSOCKET, buf : Pointer(LibC::Char), len : LibC::Int)
  # TODO udt send/recv file

  # last error detection
  fun udt_getlasterror_desc() : Pointer(LibC::Char)
  fun udt_getlasterror_code() : LibC::Int
  fun udt_clearlasterror() : Void

  # performance track
  fun udt_perfmon(u : UDTSOCKET, perf : Pointer(UDT_TRACEINFO), clear : LibC::Int) : LibC::Int

  # get UDT socket state
  fun udt_getsockstate(u : UDTSOCKET) : LibC::Int

  # event machanism
  # select and selectEX are DEPRECATED; please use epoll.
  enum UDT_EPOLLOpt
    UDT_UDT_EPOLL_IN  = 0x1
    UDT_UDT_EPOLL_OUT = 0x4
    UDT_UDT_EPOLL_ERR = 0x8
  end

  fun udt_epoll_create() : LibC::Int
  fun udt_epoll_add_usock(eid : LibC::Int, u : UDTSOCKET, events : Pointer(LibC::Int)) : LibC::Int
  fun udt_epoll_add_ssock(eid : LibC::Int, s : SYSSOCKET, events : Pointer(LibC::Int)) : LibC::Int
  fun udt_epoll_remove_usock(eid : LibC::Int, u : UDTSOCKET) : LibC::Int
  fun udt_epoll_remove_ssock(eid : LibC::Int, u : SYSSOCKET) : LibC::Int
  fun udt_epoll_wait2(eid : LibC::Int, readfds : Pointer(UDTSOCKET), rnum : Pointer(LibC::Int), writefds : Pointer(UDTSOCKET), wnum : Pointer(LibC::Int), msTimeOut : Int64, lrfds : Pointer(SYSSOCKET), lrnum : Pointer(LibC::Int), lwfds : Pointer(SYSSOCKET), lwnum : Pointer(LibC::Int))
  fun udt_epoll_release(eid : LibC::Int)
end

          
