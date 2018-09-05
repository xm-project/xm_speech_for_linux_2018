// Auto-generated. Do not edit!

// (in-package xm_speech.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class xm_Speech_meaningRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.command = null;
    }
    else {
      if (initObj.hasOwnProperty('command')) {
        this.command = initObj.command
      }
      else {
        this.command = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type xm_Speech_meaningRequest
    // Serialize message field [command]
    bufferOffset = _serializer.uint8(obj.command, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type xm_Speech_meaningRequest
    let len;
    let data = new xm_Speech_meaningRequest(null);
    // Deserialize message field [command]
    data.command = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'xm_speech/xm_Speech_meaningRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '36e1d21d1340e2a5e93f075b6457cbdf';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 command
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new xm_Speech_meaningRequest(null);
    if (msg.command !== undefined) {
      resolved.command = msg.command;
    }
    else {
      resolved.command = 0
    }

    return resolved;
    }
};

class xm_Speech_meaningResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.num = null;
      this.action = null;
      this.target = null;
      this.name = null;
      this.object = null;
    }
    else {
      if (initObj.hasOwnProperty('num')) {
        this.num = initObj.num
      }
      else {
        this.num = 0;
      }
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = [];
      }
      if (initObj.hasOwnProperty('target')) {
        this.target = initObj.target
      }
      else {
        this.target = [];
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = [];
      }
      if (initObj.hasOwnProperty('object')) {
        this.object = initObj.object
      }
      else {
        this.object = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type xm_Speech_meaningResponse
    // Serialize message field [num]
    bufferOffset = _serializer.uint8(obj.num, buffer, bufferOffset);
    // Serialize message field [action]
    bufferOffset = _arraySerializer.string(obj.action, buffer, bufferOffset, null);
    // Serialize message field [target]
    bufferOffset = _arraySerializer.string(obj.target, buffer, bufferOffset, null);
    // Serialize message field [name]
    bufferOffset = _arraySerializer.string(obj.name, buffer, bufferOffset, null);
    // Serialize message field [object]
    bufferOffset = _arraySerializer.string(obj.object, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type xm_Speech_meaningResponse
    let len;
    let data = new xm_Speech_meaningResponse(null);
    // Deserialize message field [num]
    data.num = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [action]
    data.action = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [target]
    data.target = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [name]
    data.name = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [object]
    data.object = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.action.forEach((val) => {
      length += 4 + val.length;
    });
    object.target.forEach((val) => {
      length += 4 + val.length;
    });
    object.name.forEach((val) => {
      length += 4 + val.length;
    });
    object.object.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 17;
  }

  static datatype() {
    // Returns string type for a service object
    return 'xm_speech/xm_Speech_meaningResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9a909c45e5795de673a5c67d344f8ad1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 num
    string[] action
    string[] target
    string[] name
    string[] object
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new xm_Speech_meaningResponse(null);
    if (msg.num !== undefined) {
      resolved.num = msg.num;
    }
    else {
      resolved.num = 0
    }

    if (msg.action !== undefined) {
      resolved.action = msg.action;
    }
    else {
      resolved.action = []
    }

    if (msg.target !== undefined) {
      resolved.target = msg.target;
    }
    else {
      resolved.target = []
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = []
    }

    if (msg.object !== undefined) {
      resolved.object = msg.object;
    }
    else {
      resolved.object = []
    }

    return resolved;
    }
};

module.exports = {
  Request: xm_Speech_meaningRequest,
  Response: xm_Speech_meaningResponse,
  md5sum() { return '844b59f8509f804f0390d479af52f9d8'; },
  datatype() { return 'xm_speech/xm_Speech_meaning'; }
};
