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

class xm_SpeechRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.audio_data = null;
    }
    else {
      if (initObj.hasOwnProperty('audio_data')) {
        this.audio_data = initObj.audio_data
      }
      else {
        this.audio_data = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type xm_SpeechRequest
    // Serialize message field [audio_data]
    bufferOffset = _serializer.string(obj.audio_data, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type xm_SpeechRequest
    let len;
    let data = new xm_SpeechRequest(null);
    // Deserialize message field [audio_data]
    data.audio_data = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.audio_data.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'xm_speech/xm_SpeechRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c9a22b422fef08dc125f0936449d733c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string audio_data
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new xm_SpeechRequest(null);
    if (msg.audio_data !== undefined) {
      resolved.audio_data = msg.audio_data;
    }
    else {
      resolved.audio_data = ''
    }

    return resolved;
    }
};

class xm_SpeechResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.sr_text = null;
    }
    else {
      if (initObj.hasOwnProperty('sr_text')) {
        this.sr_text = initObj.sr_text
      }
      else {
        this.sr_text = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type xm_SpeechResponse
    // Serialize message field [sr_text]
    bufferOffset = _serializer.string(obj.sr_text, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type xm_SpeechResponse
    let len;
    let data = new xm_SpeechResponse(null);
    // Deserialize message field [sr_text]
    data.sr_text = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.sr_text.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'xm_speech/xm_SpeechResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'be2c5a0cf73ac59f5bdcdbde6f1b574d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string sr_text
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new xm_SpeechResponse(null);
    if (msg.sr_text !== undefined) {
      resolved.sr_text = msg.sr_text;
    }
    else {
      resolved.sr_text = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: xm_SpeechRequest,
  Response: xm_SpeechResponse,
  md5sum() { return 'b0db70cd6474af67f2b501ae6232f04a'; },
  datatype() { return 'xm_speech/xm_Speech'; }
};
