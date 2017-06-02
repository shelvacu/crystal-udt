require "lib_udt.cr"

class UDTError < Exception
  def initialize(@message : String, @error_code : Int32)
  end
end

class UDTSocket
  @@initialized = false

  enum SocketType
    Stream = LibC::SOCK_STREAM
    Datagram = LibC::SOCK_DGRAM
  end

  macro raise_udt_err
    raise UDTError.new(String.new(LibUDT.udt_getlasterror_desc),LibUDT.udt_getlasterror_code)
  end
  
  def initialize(use_ipv4 = true, socket_type : SocketType)
    if !@@initialized
      LibUDT.udt_startup()
      @@initialized = true
    end

    if use_ipv4
      af = LibC::AF_INET
    else
      af = LibC::AF_INET6
    end
    res = LibUDT.socket(af, socket_type, 0)
    if res == LibUDT::UDT_INVALID_SOCK
      raise_udt_err
    end
    @sock = res
  end

  def connect(address : String, port : UInt16)
    #TODO
  end
end

