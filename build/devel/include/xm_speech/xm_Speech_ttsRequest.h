// Generated by gencpp from file xm_speech/xm_Speech_ttsRequest.msg
// DO NOT EDIT!


#ifndef XM_SPEECH_MESSAGE_XM_SPEECH_TTSREQUEST_H
#define XM_SPEECH_MESSAGE_XM_SPEECH_TTSREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace xm_speech
{
template <class ContainerAllocator>
struct xm_Speech_ttsRequest_
{
  typedef xm_Speech_ttsRequest_<ContainerAllocator> Type;

  xm_Speech_ttsRequest_()
    : tts_text()  {
    }
  xm_Speech_ttsRequest_(const ContainerAllocator& _alloc)
    : tts_text(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _tts_text_type;
  _tts_text_type tts_text;




  typedef boost::shared_ptr< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct xm_Speech_ttsRequest_

typedef ::xm_speech::xm_Speech_ttsRequest_<std::allocator<void> > xm_Speech_ttsRequest;

typedef boost::shared_ptr< ::xm_speech::xm_Speech_ttsRequest > xm_Speech_ttsRequestPtr;
typedef boost::shared_ptr< ::xm_speech::xm_Speech_ttsRequest const> xm_Speech_ttsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace xm_speech

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "92773628681ce47aaf225b274d20dba5";
  }

  static const char* value(const ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x92773628681ce47aULL;
  static const uint64_t static_value2 = 0xaf225b274d20dba5ULL;
};

template<class ContainerAllocator>
struct DataType< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "xm_speech/xm_Speech_ttsRequest";
  }

  static const char* value(const ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string tts_text\n\
";
  }

  static const char* value(const ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.tts_text);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct xm_Speech_ttsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::xm_speech::xm_Speech_ttsRequest_<ContainerAllocator>& v)
  {
    s << indent << "tts_text: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.tts_text);
  }
};

} // namespace message_operations
} // namespace ros

#endif // XM_SPEECH_MESSAGE_XM_SPEECH_TTSREQUEST_H