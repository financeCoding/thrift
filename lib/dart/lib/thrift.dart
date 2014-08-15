/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

library thrift;

import "dart:async";

/**
 * Thrift IDL type string to Id mapping.
 * @readonly
 * @property {number}  STOP   - End of a set of fields.
 * @property {number}  VOID   - No value (only legal for return types).
 * @property {number}  BOOL   - True/False integer.
 * @property {number}  BYTE   - Signed 8 bit integer.
 * @property {number}  I08    - Signed 8 bit integer.     
 * @property {number}  DOUBLE - 64 bit IEEE 854 floating point.
 * @property {number}  I16    - Signed 16 bit integer.
 * @property {number}  I32    - Signed 32 bit integer.
 * @property {number}  I64    - Signed 64 bit integer.
 * @property {number}  STRING - Array of bytes representing a string of characters.
 * @property {number}  UTF7   - Array of bytes representing a string of UTF7 encoded characters.
 * @property {number}  STRUCT - A multifield type.
 * @property {number}  MAP    - A collection type (map/associative-array/dictionary).
 * @property {number}  SET    - A collection type (unordered and without repeated values).
 * @property {number}  LIST   - A collection type (unordered).
 * @property {number}  UTF8   - Array of bytes representing a string of UTF8 encoded characters.
 * @property {number}  UTF16  - Array of bytes representing a string of UTF16 encoded characters.
 */
class ThriftType {
  static const int 
  STOP = 0,
  VOID = 1,
  BOOL = 2,
  BYTE = 3,
  I08 = 3,
  DOUBLE = 4,
  I16 = 6,
  I32 = 8,
  I64 = 10,
  STRING = 11,
  UTF7 = 11,
  STRUCT = 12,
  MAP = 13,
  SET = 14,
  LIST = 15,
  UTF8 = 16,
  UTF16 = 17;
}

/**
 * Thrift RPC message type string to Id mapping.
 * @readonly
 * @property {number}  CALL      - RPC call sent from client to server.
 * @property {number}  REPLY     - RPC call normal response from server to client.
 * @property {number}  EXCEPTION - RPC call exception response from server to client.
 * @property {number}  ONEWAY    - Oneway RPC call from client to server with no response.
 */
class ThriftMessageType {
  static const int 
  CALL = 1,
  REPLY = 2,
  EXCEPTION = 3,
  ONEWAY = 4;
}

class TException {
  String message;
  TException(this.message);
}

/**
 * Thrift Application Exception type string to Id mapping.
 * @readonly
 * @property {number}  UNKNOWN                 - Unknown/undefined.
 * @property {number}  UNKNOWN_METHOD          - Client attempted to call a method unknown to the server.
 * @property {number}  INVALID_MESSAGE_TYPE    - Client passed an unknown/unsupported MessageType.
 * @property {number}  WRONG_METHOD_NAME       - Unused.
 * @property {number}  BAD_SEQUENCE_ID         - Unused in Thrift RPC, used to flag proprietary sequence number errors.
 * @property {number}  MISSING_RESULT          - Raised by a server processor if a handler fails to supply the required return result.
 * @property {number}  INTERNAL_ERROR          - Something bad happened.
 * @property {number}  PROTOCOL_ERROR          - The protocol layer failed to serialize or deserialize data.
 * @property {number}  INVALID_TRANSFORM       - Unused.
 * @property {number}  INVALID_PROTOCOL        - The protocol (or version) is not supported.
 * @property {number}  UNSUPPORTED_CLIENT_TYPE - Unused.
 */
class TApplicationExceptionType {
  static const int 
  UNKNOWN = 0,
  UNKNOWN_METHOD = 1,
  INVALID_MESSAGE_TYPE = 2,
  WRONG_METHOD_NAME = 3,
  BAD_SEQUENCE_ID = 4,
  MISSING_RESULT = 5,
  INTERNAL_ERROR = 6,
  PROTOCOL_ERROR = 7,
  INVALID_TRANSFORM = 8,
  INVALID_PROTOCOL = 9,
  UNSUPPORTED_CLIENT_TYPE = 10;
}

class TApplicationException extends TException {
  int code;
  TApplicationException(message, this.code) : super(message);
  
  void read(input) {
    throw new UnimplementedError();
  }
  
  void write(output) {
    throw new UnimplementedError();
  }
  
  int getCode() => code; // TODO: no need for getCode.
}

class Transport extends TXHRTransport {
  String url;
  bool useCORS;
  int wpos = 0, rpos = 0;
  String send_buf = '', recv_buf = ''; // TODO: Use something more efficent. 
  Transport(this.url, this.useCORS);
  
}

class TXHRTransport {
  
  Future flush(async) {
    throw new UnimplementedError();
  }
  
  /**
   * Sets the buffer to provide the protocol when deserializing.
   * @param {string} buf - The buffer to supply the protocol.
   */
  void setRecvBuffer(buf) {
    throw new UnimplementedError();
  }
  
  /**
   * Returns true if the transport is open, XHR always returns true.
   * @readonly
   * @returns {boolean} Always True.
   */    
  bool isOpen() {
    throw new UnimplementedError();
  }

  /**
   * Opens the transport connection, with XHR this is a nop.
   */    
  open() {}

  /**
   * Closes the transport connection, with XHR this is a nop.
   */    
  close() {}

  /**
   * Returns the specified number of characters from the response
   * buffer.
   * @param {number} len - The number of characters to return.
   * @returns {string} Characters sent by the server.
   */
  String read(len) {
    throw new UnimplementedError();
  }

  /**
   * Returns the entire response buffer.
   * @returns {string} Characters sent by the server.
   */
  String readAll() {
    throw new UnimplementedError();
  }

  /**
   * Sets the send buffer to buf.
   * @param {string} buf - The buffer to send.
   */    
  void write(buf) {
    throw new UnimplementedError();
  }

  /**
   * Returns the send buffer.
   * @readonly
   * @returns {string} The send buffer.
   */ 
  String getSendBuffer() {
    throw new UnimplementedError();
  }
}

class TWebSocketTransport {
  String url;             //Where to connect
  var socket = null;         //The web socket
  //TODO: should prob be a stream.
  List callbacks = [];        //Pending callbacks
  // TODO: should prob be a stream.
  List send_pending = [];     //Buffers/Callback pairs waiting to be sent
  String send_buf = '';         //Outbound data, immutable until sent
  String recv_buf = '';         //Inbound data
  int rb_wpos = 0;           //Network write position in receive buffer
  int rb_rpos = 0;           //Client read position in receive buffer
  
  TWebSocketTransport(this.url) {
    throw new UnimplementedError();
  }
  
  /**
   * Sets the buffer to use when receiving server responses.
   * @param {string} buf - The buffer to receive server responses.
   */
  setRecvBuffer(buf) {
    throw new UnimplementedError();
  }
  
  /**
   * Returns true if the transport is open
   * @readonly
   * @returns {boolean} 
   */    
  isOpen() {
    throw new UnimplementedError();
  }
  
  /**
   * Opens the transport connection
   */    
  open() {
    throw new UnimplementedError();
  }
  
  /**
   * Closes the transport connection
   */    
  close() {
    throw new UnimplementedError();
  }
  
  /**
   * Returns the specified number of characters from the response
   * buffer.
   * @param {number} len - The number of characters to return.
   * @returns {string} Characters sent by the server.
   */
  read(len) {
    throw new UnimplementedError();
  }
  
  /**
   * Returns the entire response buffer.
   * @returns {string} Characters sent by the server.
   */
  readAll() {
    throw new UnimplementedError();
  }
  
  /**
   * Sets the send buffer to buf.
   * @param {string} buf - The buffer to send.
   */    
  write(buf) {
    throw new UnimplementedError();
  }
  
  /**
   * Returns the send buffer.
   * @readonly
   * @returns {string} The send buffer.
   */ 
  getSendBuffer() {
    throw new UnimplementedError();
  }
}

class TJSONProtocol extends Protocol {
  var transport;
  TJSONProtocol(this.transport);
}

/**
 * Thrift IDL type Id to string mapping.
 * @readonly
 * @see {@link Thrift.Type}
 */
const ProtocolType = const {
  ThriftType.BOOL : '"tf"',
  ThriftType.BYTE : '"i8"',
  ThriftType.I16 : '"i16"',
  ThriftType.I32 : '"i32"',
  ThriftType.I64 : '"i64"',
  ThriftType.DOUBLE : '"dbl"',
  ThriftType.STRUCT : '"rec"',
  ThriftType.STRING : '"str"',
  ThriftType.MAP : '"map"',
  ThriftType.LIST : '"lst"',
  ThriftType.SET : '"set"'
};

/**
 * Thrift IDL type string to Id mapping.
 * @readonly
 * @see {@link Thrift.Type}
 */
class ProtocolRType {
  static const tf = ThriftType.BOOL;
  static const i8 = ThriftType.BYTE;
  static const i16 = ThriftType.I16;
  static const i32 = ThriftType.I32;
  static const i64 = ThriftType.I64;
  static const dbl = ThriftType.DOUBLE;
  static const rec = ThriftType.STRUCT;
  static const str = ThriftType.STRING;
  static const map = ThriftType.MAP;
  static const lst = ThriftType.LIST;
  static const set = ThriftType.SET;
}

final ProtocolVersion = 1;

class Protocol {
  /**
   * Returns the underlying transport.
   * @readonly
   * @returns {Thrift.Transport} The underlying transport.
   */ 
  getTransport() {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the beginning of a Thrift RPC message.
   * @param {string} name - The service method to call.
   * @param {Thrift.MessageType} messageType - The type of method call.
   * @param {number} seqid - The sequence number of this call (always 0 in Apache Thrift).
   */
  writeMessageBegin(name, messageType, seqid) {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the end of a Thrift RPC message.
   */
  writeMessageEnd() {
    throw new UnimplementedError();  
  }
  
  /**
   * Serializes the beginning of a struct.
   * @param {string} name - The name of the struct.
   */
  writeStructBegin(name) {
    throw new UnimplementedError(); 
  }
  
  /**
   * Serializes the end of a struct.
   */
  writeStructEnd() {
    throw new UnimplementedError(); 
  }

  /**
   * Serializes the beginning of a struct field.
   * @param {string} name - The name of the field.
   * @param {Thrift.Protocol.Type} fieldType - The data type of the field.
   * @param {number} fieldId - The field's unique identifier.
   */
  writeFieldBegin(name, fieldType, fieldId) {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the end of a field.
   */
  writeFieldEnd() {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the end of the set of fields for a struct.
   */
  writeFieldStop() {
      //na
  }
  
  /**
   * Serializes the beginning of a map collection.
   * @param {Thrift.Type} keyType - The data type of the key.
   * @param {Thrift.Type} valType - The data type of the value.
   * @param {number} [size] - The number of elements in the map (ignored).
   */
  writeMapBegin(keyType, valType, size) {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the end of a map.
   */
  writeMapEnd() {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the beginning of a list collection.
   * @param {Thrift.Type} elemType - The data type of the elements.
   * @param {number} size - The number of elements in the list.
   */
  writeListBegin(elemType, size) {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the end of a list.
   */
  writeListEnd() {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the beginning of a set collection.
   * @param {Thrift.Type} elemType - The data type of the elements.
   * @param {number} size - The number of elements in the list.
   */
  writeSetBegin(elemType, size) {
    throw new UnimplementedError();
  }
  
  /**
   * Serializes the end of a set.
   */
  writeSetEnd() {
    throw new UnimplementedError();
  }
  
  /** Serializes a boolean */
  writeBool(value) {
    throw new UnimplementedError();
  }

  /** Serializes a number */
  writeByte(i8) {
    throw new UnimplementedError();
  }

  /** Serializes a number */
  writeI16(i16) {
    throw new UnimplementedError();
  }

  /** Serializes a number */
  writeI32(i32) {
    throw new UnimplementedError();
  }

  /** Serializes a number */
  writeI64(i64) {
    throw new UnimplementedError();
  }

  /** Serializes a number */
  writeDouble(dbl) {
    throw new UnimplementedError();
  }
  
  /** Serializes a string */
  writeString(str) {
    throw new UnimplementedError();
  }
  
  /** Serializes a string */
  writeBinary(str) {
    throw new UnimplementedError();
  }
  
  /**
     @class
     @name AnonReadMessageBeginReturn
     @property {string} fname - The name of the service method.
     @property {Thrift.MessageType} mtype - The type of message call.
     @property {number} rseqid - The sequence number of the message (0 in Thrift RPC).
   */
  /** 
   * Deserializes the beginning of a message. 
   * @returns {AnonReadMessageBeginReturn}
   */
  readMessageBegin() {
    throw new UnimplementedError();
  }
  
  /** Deserializes the end of a message. */
  readMessageEnd() {
    throw new UnimplementedError();
  }
  
  /** 
   * Deserializes the beginning of a struct. 
   * @param {string} [name] - The name of the struct (ignored)
   * @returns {object} - An object with an empty string fname property
   */    
  readStructBegin(name) {
    throw new UnimplementedError();
  }
  
  /** Deserializes the end of a struct. */
  readStructEnd() {
    throw new UnimplementedError();
  }
  
  /**
     @class
     @name AnonReadFieldBeginReturn
     @property {string} fname - The name of the field (always '').
     @property {Thrift.Type} ftype - The data type of the field.
     @property {number} fid - The unique identifier of the field.
   */
  /** 
   * Deserializes the beginning of a field. 
   * @returns {AnonReadFieldBeginReturn}
   */
  readFieldBegin() {
    throw new UnimplementedError();
  }
  

  /** Deserializes the end of a field. */
  readFieldEnd() {
    throw new UnimplementedError();
  }

  /**
     @class
     @name AnonReadMapBeginReturn
     @property {Thrift.Type} ktype - The data type of the key.
     @property {Thrift.Type} vtype - The data type of the value.
     @property {number} size - The number of elements in the map.
   */
  /** 
   * Deserializes the beginning of a map. 
   * @returns {AnonReadMapBeginReturn}
   */
  readMapBegin() {
    throw new UnimplementedError();
  }

  /** Deserializes the end of a map. */
  readMapEnd() {
    throw new UnimplementedError();
  }

  /**
     @class
     @name AnonReadColBeginReturn
     @property {Thrift.Type} etype - The data type of the element.
     @property {number} size - The number of elements in the collection.
   */
  /** 
   * Deserializes the beginning of a list. 
   * @returns {AnonReadColBeginReturn}
   */
  readListBegin() {
    throw new UnimplementedError();
  }

  /** Deserializes the end of a list. */
  readListEnd() {
    throw new UnimplementedError();
  }

  /** 
   * Deserializes the beginning of a set. 
   * @returns {AnonReadColBeginReturn}
   */
  readSetBegin(elemType, size) {
    throw new UnimplementedError();
  }

  /** Deserializes the end of a set. */
  readSetEnd() {
    throw new UnimplementedError();
  }

  /** Returns an object with a value property set to 
   *  False unless the next number in the protocol buffer 
   *  is 1, in which case teh value property is True */
  readBool() {
    throw new UnimplementedError();
  }

  /** Returns the an object with a value property set to the 
      next value found in the protocol buffer */
  readByte() {
    throw new UnimplementedError();
  }

  /** Returns the an object with a value property set to the 
      next value found in the protocol buffer */
  readI16() {
    throw new UnimplementedError();
  }

  /** Returns the an object with a value property set to the 
      next value found in the protocol buffer */
  readI32(f) {
    throw new UnimplementedError();
  }

  /** Returns the an object with a value property set to the 
      next value found in the protocol buffer */
  readI64() {
    throw new UnimplementedError();
  }

  /** Returns the an object with a value property set to the 
      next value found in the protocol buffer */
  readDouble() {
    throw new UnimplementedError();
  }

  /** Returns the an object with a value property set to the 
      next value found in the protocol buffer */
  readString() {
    throw new UnimplementedError();
  }

  /** Returns the an object with a value property set to the 
      next value found in the protocol buffer */
  readBinary() {
    throw new UnimplementedError();
  }

  /** 
   * Method to arbitrarily skip over data */
  skip(type) {
    throw new UnimplementedError();
  }
}

/**
 * Initializes a MutilplexProtocol Implementation as a Wrapper for Thrift.Protocol
 * @constructor
 */
class MultiplexProtocol extends Protocol {
  MultiplexProtocol(srvName, trans, strictRead, strictWrite) {
    throw new UnimplementedError();
  }
  
  writeMessageBegin(name, type, seqid) {
    throw new UnimplementedError();
  }
}

class Multiplexer {
  //TODO: figure out the multiplexer support. 
}

//Thrift.Multiplexer = function () {
//    this.seqid = 0;
//};
//
///** Instantiates a multiplexed client for a specific service
// * @constructor
// * @param {String} serviceName - The transport to serialize to/from.
// * @param {Thrift.ServiceClient} SCl - The Service Client Class
// * @param {Thrift.Transport} transport - Thrift.Transport instance which provides remote host:port
// * @example
// *    var mp = new Thrift.Multiplexer();
// *    var transport = new Thrift.Transport("http://localhost:9090/foo.thrift");
// *    var protocol = new Thrift.Protocol(transport);
// *    var client = mp.createClient('AuthService', AuthServiceClient, transport);
//*/
//Thrift.Multiplexer.prototype.createClient = function (serviceName, SCl, transport) {
//    if (SCl.Client) {
//        SCl = SCl.Client;
//    }
//    var self = this;
//    SCl.prototype.new_seqid = function () {
//        self.seqid += 1;
//        return self.seqid;
//    };
//    var client = new SCl(new Thrift.MultiplexProtocol(serviceName, transport));
//
//    return client;
//};
