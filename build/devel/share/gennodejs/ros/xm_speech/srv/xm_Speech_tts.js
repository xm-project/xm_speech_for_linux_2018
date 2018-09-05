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

class xm_Speech_ttsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.tts_text = null;
    }
    else {
      if (initObj.hasOwnProperty('tts_text')) {
        this.tts_text = initObj.tts_text
      }
      else {
        this.tts_text = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type xm_Speech_ttsRequest
    // Serialize message field [tts_text]
    bufferOffset = _serializer.string(obj.tts_text, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type xm_Speech_ttsRequest
    let len;
    let data = new xm_Speech_ttsRequest(null);
    // Deserialize message field [tts_text]
    data.tts_text = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.tts_text.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'xm_speech/xm_Speech_ttsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '92773628681ce47aaf225b274d20dba5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string tts_text
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new xm_Speech_ttsRequest(null);
    if (msg.tts_text !== undefined) {
      resolved.tts_text = msg.tts_text;
    }
    else {
      resolved.tts_text = ''
    }

    return resolved;
    }
};

class xm_Speech_ttsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.flag = null;
    }
    else {
      if (initObj.hasOwnProperty('flag')) {
        this.flag = initObj.flag
      }
      else {
        this.flag = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type xm_Speech_ttsResponse
    // Serialize message field [flag]
    bufferOffset = _serializer.uint8(obj.flag, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type xm_Speech_ttsResponse
    let len;
    let data = new xm_Speech_ttsResponse(null);
    // Deserialize message field [flag]
    data.flag = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'xm_speech/xm_Speech_ttsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b6a8907dbdc46dea839fb59e243dc983';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 flag
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new xm_Speech_ttsResponse(null);
    if (msg.flag !== undefined) {
      resolved.flag = msg.flag;
    }
    else {
      resolved.flag = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: xm_Speech_ttsRequest,
  Response: xm_Speech_ttsResponse,
  md5sum() { return '6c25999b48630da1ebe398b2997ee386'; },
  datatype() { return 'xm_speech/xm_Speech_tts'; }
};
