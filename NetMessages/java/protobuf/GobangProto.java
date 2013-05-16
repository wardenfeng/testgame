// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: GobangProto.proto

package protobuf;

public final class GobangProto {
  private GobangProto() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
  }
  public interface SSPKG_LOGIN_REQOrBuilder
      extends com.google.protobuf.MessageOrBuilder {
    
    // required string account = 1;
    boolean hasAccount();
    String getAccount();
    
    // required string password = 2;
    boolean hasPassword();
    String getPassword();
  }
  public static final class SSPKG_LOGIN_REQ extends
      com.google.protobuf.GeneratedMessage
      implements SSPKG_LOGIN_REQOrBuilder {
    // Use SSPKG_LOGIN_REQ.newBuilder() to construct.
    private SSPKG_LOGIN_REQ(Builder builder) {
      super(builder);
    }
    private SSPKG_LOGIN_REQ(boolean noInit) {}
    
    private static final SSPKG_LOGIN_REQ defaultInstance;
    public static SSPKG_LOGIN_REQ getDefaultInstance() {
      return defaultInstance;
    }
    
    public SSPKG_LOGIN_REQ getDefaultInstanceForType() {
      return defaultInstance;
    }
    
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_REQ_descriptor;
    }
    
    protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_REQ_fieldAccessorTable;
    }
    
    private int bitField0_;
    // required string account = 1;
    public static final int ACCOUNT_FIELD_NUMBER = 1;
    private java.lang.Object account_;
    public boolean hasAccount() {
      return ((bitField0_ & 0x00000001) == 0x00000001);
    }
    public String getAccount() {
      java.lang.Object ref = account_;
      if (ref instanceof String) {
        return (String) ref;
      } else {
        com.google.protobuf.ByteString bs = 
            (com.google.protobuf.ByteString) ref;
        String s = bs.toStringUtf8();
        if (com.google.protobuf.Internal.isValidUtf8(bs)) {
          account_ = s;
        }
        return s;
      }
    }
    private com.google.protobuf.ByteString getAccountBytes() {
      java.lang.Object ref = account_;
      if (ref instanceof String) {
        com.google.protobuf.ByteString b = 
            com.google.protobuf.ByteString.copyFromUtf8((String) ref);
        account_ = b;
        return b;
      } else {
        return (com.google.protobuf.ByteString) ref;
      }
    }
    
    // required string password = 2;
    public static final int PASSWORD_FIELD_NUMBER = 2;
    private java.lang.Object password_;
    public boolean hasPassword() {
      return ((bitField0_ & 0x00000002) == 0x00000002);
    }
    public String getPassword() {
      java.lang.Object ref = password_;
      if (ref instanceof String) {
        return (String) ref;
      } else {
        com.google.protobuf.ByteString bs = 
            (com.google.protobuf.ByteString) ref;
        String s = bs.toStringUtf8();
        if (com.google.protobuf.Internal.isValidUtf8(bs)) {
          password_ = s;
        }
        return s;
      }
    }
    private com.google.protobuf.ByteString getPasswordBytes() {
      java.lang.Object ref = password_;
      if (ref instanceof String) {
        com.google.protobuf.ByteString b = 
            com.google.protobuf.ByteString.copyFromUtf8((String) ref);
        password_ = b;
        return b;
      } else {
        return (com.google.protobuf.ByteString) ref;
      }
    }
    
    private void initFields() {
      account_ = "";
      password_ = "";
    }
    private byte memoizedIsInitialized = -1;
    public final boolean isInitialized() {
      byte isInitialized = memoizedIsInitialized;
      if (isInitialized != -1) return isInitialized == 1;
      
      if (!hasAccount()) {
        memoizedIsInitialized = 0;
        return false;
      }
      if (!hasPassword()) {
        memoizedIsInitialized = 0;
        return false;
      }
      memoizedIsInitialized = 1;
      return true;
    }
    
    public void writeTo(com.google.protobuf.CodedOutputStream output)
                        throws java.io.IOException {
      getSerializedSize();
      if (((bitField0_ & 0x00000001) == 0x00000001)) {
        output.writeBytes(1, getAccountBytes());
      }
      if (((bitField0_ & 0x00000002) == 0x00000002)) {
        output.writeBytes(2, getPasswordBytes());
      }
      getUnknownFields().writeTo(output);
    }
    
    private int memoizedSerializedSize = -1;
    public int getSerializedSize() {
      int size = memoizedSerializedSize;
      if (size != -1) return size;
    
      size = 0;
      if (((bitField0_ & 0x00000001) == 0x00000001)) {
        size += com.google.protobuf.CodedOutputStream
          .computeBytesSize(1, getAccountBytes());
      }
      if (((bitField0_ & 0x00000002) == 0x00000002)) {
        size += com.google.protobuf.CodedOutputStream
          .computeBytesSize(2, getPasswordBytes());
      }
      size += getUnknownFields().getSerializedSize();
      memoizedSerializedSize = size;
      return size;
    }
    
    private static final long serialVersionUID = 0L;
    @java.lang.Override
    protected java.lang.Object writeReplace()
        throws java.io.ObjectStreamException {
      return super.writeReplace();
    }
    
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      Builder builder = newBuilder();
      if (builder.mergeDelimitedFrom(input)) {
        return builder.buildParsed();
      } else {
        return null;
      }
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      Builder builder = newBuilder();
      if (builder.mergeDelimitedFrom(input, extensionRegistry)) {
        return builder.buildParsed();
      } else {
        return null;
      }
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_REQ parseFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    
    public static Builder newBuilder() { return Builder.create(); }
    public Builder newBuilderForType() { return newBuilder(); }
    public static Builder newBuilder(protobuf.GobangProto.SSPKG_LOGIN_REQ prototype) {
      return newBuilder().mergeFrom(prototype);
    }
    public Builder toBuilder() { return newBuilder(this); }
    
    @java.lang.Override
    protected Builder newBuilderForType(
        com.google.protobuf.GeneratedMessage.BuilderParent parent) {
      Builder builder = new Builder(parent);
      return builder;
    }
    public static final class Builder extends
        com.google.protobuf.GeneratedMessage.Builder<Builder>
       implements protobuf.GobangProto.SSPKG_LOGIN_REQOrBuilder {
      public static final com.google.protobuf.Descriptors.Descriptor
          getDescriptor() {
        return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_REQ_descriptor;
      }
      
      protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
          internalGetFieldAccessorTable() {
        return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_REQ_fieldAccessorTable;
      }
      
      // Construct using protobuf.GobangProto.SSPKG_LOGIN_REQ.newBuilder()
      private Builder() {
        maybeForceBuilderInitialization();
      }
      
      private Builder(BuilderParent parent) {
        super(parent);
        maybeForceBuilderInitialization();
      }
      private void maybeForceBuilderInitialization() {
        if (com.google.protobuf.GeneratedMessage.alwaysUseFieldBuilders) {
        }
      }
      private static Builder create() {
        return new Builder();
      }
      
      public Builder clear() {
        super.clear();
        account_ = "";
        bitField0_ = (bitField0_ & ~0x00000001);
        password_ = "";
        bitField0_ = (bitField0_ & ~0x00000002);
        return this;
      }
      
      public Builder clone() {
        return create().mergeFrom(buildPartial());
      }
      
      public com.google.protobuf.Descriptors.Descriptor
          getDescriptorForType() {
        return protobuf.GobangProto.SSPKG_LOGIN_REQ.getDescriptor();
      }
      
      public protobuf.GobangProto.SSPKG_LOGIN_REQ getDefaultInstanceForType() {
        return protobuf.GobangProto.SSPKG_LOGIN_REQ.getDefaultInstance();
      }
      
      public protobuf.GobangProto.SSPKG_LOGIN_REQ build() {
        protobuf.GobangProto.SSPKG_LOGIN_REQ result = buildPartial();
        if (!result.isInitialized()) {
          throw newUninitializedMessageException(result);
        }
        return result;
      }
      
      private protobuf.GobangProto.SSPKG_LOGIN_REQ buildParsed()
          throws com.google.protobuf.InvalidProtocolBufferException {
        protobuf.GobangProto.SSPKG_LOGIN_REQ result = buildPartial();
        if (!result.isInitialized()) {
          throw newUninitializedMessageException(
            result).asInvalidProtocolBufferException();
        }
        return result;
      }
      
      public protobuf.GobangProto.SSPKG_LOGIN_REQ buildPartial() {
        protobuf.GobangProto.SSPKG_LOGIN_REQ result = new protobuf.GobangProto.SSPKG_LOGIN_REQ(this);
        int from_bitField0_ = bitField0_;
        int to_bitField0_ = 0;
        if (((from_bitField0_ & 0x00000001) == 0x00000001)) {
          to_bitField0_ |= 0x00000001;
        }
        result.account_ = account_;
        if (((from_bitField0_ & 0x00000002) == 0x00000002)) {
          to_bitField0_ |= 0x00000002;
        }
        result.password_ = password_;
        result.bitField0_ = to_bitField0_;
        onBuilt();
        return result;
      }
      
      public Builder mergeFrom(com.google.protobuf.Message other) {
        if (other instanceof protobuf.GobangProto.SSPKG_LOGIN_REQ) {
          return mergeFrom((protobuf.GobangProto.SSPKG_LOGIN_REQ)other);
        } else {
          super.mergeFrom(other);
          return this;
        }
      }
      
      public Builder mergeFrom(protobuf.GobangProto.SSPKG_LOGIN_REQ other) {
        if (other == protobuf.GobangProto.SSPKG_LOGIN_REQ.getDefaultInstance()) return this;
        if (other.hasAccount()) {
          setAccount(other.getAccount());
        }
        if (other.hasPassword()) {
          setPassword(other.getPassword());
        }
        this.mergeUnknownFields(other.getUnknownFields());
        return this;
      }
      
      public final boolean isInitialized() {
        if (!hasAccount()) {
          
          return false;
        }
        if (!hasPassword()) {
          
          return false;
        }
        return true;
      }
      
      public Builder mergeFrom(
          com.google.protobuf.CodedInputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws java.io.IOException {
        com.google.protobuf.UnknownFieldSet.Builder unknownFields =
          com.google.protobuf.UnknownFieldSet.newBuilder(
            this.getUnknownFields());
        while (true) {
          int tag = input.readTag();
          switch (tag) {
            case 0:
              this.setUnknownFields(unknownFields.build());
              onChanged();
              return this;
            default: {
              if (!parseUnknownField(input, unknownFields,
                                     extensionRegistry, tag)) {
                this.setUnknownFields(unknownFields.build());
                onChanged();
                return this;
              }
              break;
            }
            case 10: {
              bitField0_ |= 0x00000001;
              account_ = input.readBytes();
              break;
            }
            case 18: {
              bitField0_ |= 0x00000002;
              password_ = input.readBytes();
              break;
            }
          }
        }
      }
      
      private int bitField0_;
      
      // required string account = 1;
      private java.lang.Object account_ = "";
      public boolean hasAccount() {
        return ((bitField0_ & 0x00000001) == 0x00000001);
      }
      public String getAccount() {
        java.lang.Object ref = account_;
        if (!(ref instanceof String)) {
          String s = ((com.google.protobuf.ByteString) ref).toStringUtf8();
          account_ = s;
          return s;
        } else {
          return (String) ref;
        }
      }
      public Builder setAccount(String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  bitField0_ |= 0x00000001;
        account_ = value;
        onChanged();
        return this;
      }
      public Builder clearAccount() {
        bitField0_ = (bitField0_ & ~0x00000001);
        account_ = getDefaultInstance().getAccount();
        onChanged();
        return this;
      }
      void setAccount(com.google.protobuf.ByteString value) {
        bitField0_ |= 0x00000001;
        account_ = value;
        onChanged();
      }
      
      // required string password = 2;
      private java.lang.Object password_ = "";
      public boolean hasPassword() {
        return ((bitField0_ & 0x00000002) == 0x00000002);
      }
      public String getPassword() {
        java.lang.Object ref = password_;
        if (!(ref instanceof String)) {
          String s = ((com.google.protobuf.ByteString) ref).toStringUtf8();
          password_ = s;
          return s;
        } else {
          return (String) ref;
        }
      }
      public Builder setPassword(String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  bitField0_ |= 0x00000002;
        password_ = value;
        onChanged();
        return this;
      }
      public Builder clearPassword() {
        bitField0_ = (bitField0_ & ~0x00000002);
        password_ = getDefaultInstance().getPassword();
        onChanged();
        return this;
      }
      void setPassword(com.google.protobuf.ByteString value) {
        bitField0_ |= 0x00000002;
        password_ = value;
        onChanged();
      }
      
      // @@protoc_insertion_point(builder_scope:protobuf.SSPKG_LOGIN_REQ)
    }
    
    static {
      defaultInstance = new SSPKG_LOGIN_REQ(true);
      defaultInstance.initFields();
    }
    
    // @@protoc_insertion_point(class_scope:protobuf.SSPKG_LOGIN_REQ)
  }
  
  public interface SSPKG_LOGIN_ACKOrBuilder
      extends com.google.protobuf.MessageOrBuilder {
    
    // required bool success = 1;
    boolean hasSuccess();
    boolean getSuccess();
  }
  public static final class SSPKG_LOGIN_ACK extends
      com.google.protobuf.GeneratedMessage
      implements SSPKG_LOGIN_ACKOrBuilder {
    // Use SSPKG_LOGIN_ACK.newBuilder() to construct.
    private SSPKG_LOGIN_ACK(Builder builder) {
      super(builder);
    }
    private SSPKG_LOGIN_ACK(boolean noInit) {}
    
    private static final SSPKG_LOGIN_ACK defaultInstance;
    public static SSPKG_LOGIN_ACK getDefaultInstance() {
      return defaultInstance;
    }
    
    public SSPKG_LOGIN_ACK getDefaultInstanceForType() {
      return defaultInstance;
    }
    
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_ACK_descriptor;
    }
    
    protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_ACK_fieldAccessorTable;
    }
    
    private int bitField0_;
    // required bool success = 1;
    public static final int SUCCESS_FIELD_NUMBER = 1;
    private boolean success_;
    public boolean hasSuccess() {
      return ((bitField0_ & 0x00000001) == 0x00000001);
    }
    public boolean getSuccess() {
      return success_;
    }
    
    private void initFields() {
      success_ = false;
    }
    private byte memoizedIsInitialized = -1;
    public final boolean isInitialized() {
      byte isInitialized = memoizedIsInitialized;
      if (isInitialized != -1) return isInitialized == 1;
      
      if (!hasSuccess()) {
        memoizedIsInitialized = 0;
        return false;
      }
      memoizedIsInitialized = 1;
      return true;
    }
    
    public void writeTo(com.google.protobuf.CodedOutputStream output)
                        throws java.io.IOException {
      getSerializedSize();
      if (((bitField0_ & 0x00000001) == 0x00000001)) {
        output.writeBool(1, success_);
      }
      getUnknownFields().writeTo(output);
    }
    
    private int memoizedSerializedSize = -1;
    public int getSerializedSize() {
      int size = memoizedSerializedSize;
      if (size != -1) return size;
    
      size = 0;
      if (((bitField0_ & 0x00000001) == 0x00000001)) {
        size += com.google.protobuf.CodedOutputStream
          .computeBoolSize(1, success_);
      }
      size += getUnknownFields().getSerializedSize();
      memoizedSerializedSize = size;
      return size;
    }
    
    private static final long serialVersionUID = 0L;
    @java.lang.Override
    protected java.lang.Object writeReplace()
        throws java.io.ObjectStreamException {
      return super.writeReplace();
    }
    
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return newBuilder().mergeFrom(data, extensionRegistry)
               .buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      Builder builder = newBuilder();
      if (builder.mergeDelimitedFrom(input)) {
        return builder.buildParsed();
      } else {
        return null;
      }
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      Builder builder = newBuilder();
      if (builder.mergeDelimitedFrom(input, extensionRegistry)) {
        return builder.buildParsed();
      } else {
        return null;
      }
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input).buildParsed();
    }
    public static protobuf.GobangProto.SSPKG_LOGIN_ACK parseFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return newBuilder().mergeFrom(input, extensionRegistry)
               .buildParsed();
    }
    
    public static Builder newBuilder() { return Builder.create(); }
    public Builder newBuilderForType() { return newBuilder(); }
    public static Builder newBuilder(protobuf.GobangProto.SSPKG_LOGIN_ACK prototype) {
      return newBuilder().mergeFrom(prototype);
    }
    public Builder toBuilder() { return newBuilder(this); }
    
    @java.lang.Override
    protected Builder newBuilderForType(
        com.google.protobuf.GeneratedMessage.BuilderParent parent) {
      Builder builder = new Builder(parent);
      return builder;
    }
    public static final class Builder extends
        com.google.protobuf.GeneratedMessage.Builder<Builder>
       implements protobuf.GobangProto.SSPKG_LOGIN_ACKOrBuilder {
      public static final com.google.protobuf.Descriptors.Descriptor
          getDescriptor() {
        return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_ACK_descriptor;
      }
      
      protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
          internalGetFieldAccessorTable() {
        return protobuf.GobangProto.internal_static_protobuf_SSPKG_LOGIN_ACK_fieldAccessorTable;
      }
      
      // Construct using protobuf.GobangProto.SSPKG_LOGIN_ACK.newBuilder()
      private Builder() {
        maybeForceBuilderInitialization();
      }
      
      private Builder(BuilderParent parent) {
        super(parent);
        maybeForceBuilderInitialization();
      }
      private void maybeForceBuilderInitialization() {
        if (com.google.protobuf.GeneratedMessage.alwaysUseFieldBuilders) {
        }
      }
      private static Builder create() {
        return new Builder();
      }
      
      public Builder clear() {
        super.clear();
        success_ = false;
        bitField0_ = (bitField0_ & ~0x00000001);
        return this;
      }
      
      public Builder clone() {
        return create().mergeFrom(buildPartial());
      }
      
      public com.google.protobuf.Descriptors.Descriptor
          getDescriptorForType() {
        return protobuf.GobangProto.SSPKG_LOGIN_ACK.getDescriptor();
      }
      
      public protobuf.GobangProto.SSPKG_LOGIN_ACK getDefaultInstanceForType() {
        return protobuf.GobangProto.SSPKG_LOGIN_ACK.getDefaultInstance();
      }
      
      public protobuf.GobangProto.SSPKG_LOGIN_ACK build() {
        protobuf.GobangProto.SSPKG_LOGIN_ACK result = buildPartial();
        if (!result.isInitialized()) {
          throw newUninitializedMessageException(result);
        }
        return result;
      }
      
      private protobuf.GobangProto.SSPKG_LOGIN_ACK buildParsed()
          throws com.google.protobuf.InvalidProtocolBufferException {
        protobuf.GobangProto.SSPKG_LOGIN_ACK result = buildPartial();
        if (!result.isInitialized()) {
          throw newUninitializedMessageException(
            result).asInvalidProtocolBufferException();
        }
        return result;
      }
      
      public protobuf.GobangProto.SSPKG_LOGIN_ACK buildPartial() {
        protobuf.GobangProto.SSPKG_LOGIN_ACK result = new protobuf.GobangProto.SSPKG_LOGIN_ACK(this);
        int from_bitField0_ = bitField0_;
        int to_bitField0_ = 0;
        if (((from_bitField0_ & 0x00000001) == 0x00000001)) {
          to_bitField0_ |= 0x00000001;
        }
        result.success_ = success_;
        result.bitField0_ = to_bitField0_;
        onBuilt();
        return result;
      }
      
      public Builder mergeFrom(com.google.protobuf.Message other) {
        if (other instanceof protobuf.GobangProto.SSPKG_LOGIN_ACK) {
          return mergeFrom((protobuf.GobangProto.SSPKG_LOGIN_ACK)other);
        } else {
          super.mergeFrom(other);
          return this;
        }
      }
      
      public Builder mergeFrom(protobuf.GobangProto.SSPKG_LOGIN_ACK other) {
        if (other == protobuf.GobangProto.SSPKG_LOGIN_ACK.getDefaultInstance()) return this;
        if (other.hasSuccess()) {
          setSuccess(other.getSuccess());
        }
        this.mergeUnknownFields(other.getUnknownFields());
        return this;
      }
      
      public final boolean isInitialized() {
        if (!hasSuccess()) {
          
          return false;
        }
        return true;
      }
      
      public Builder mergeFrom(
          com.google.protobuf.CodedInputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws java.io.IOException {
        com.google.protobuf.UnknownFieldSet.Builder unknownFields =
          com.google.protobuf.UnknownFieldSet.newBuilder(
            this.getUnknownFields());
        while (true) {
          int tag = input.readTag();
          switch (tag) {
            case 0:
              this.setUnknownFields(unknownFields.build());
              onChanged();
              return this;
            default: {
              if (!parseUnknownField(input, unknownFields,
                                     extensionRegistry, tag)) {
                this.setUnknownFields(unknownFields.build());
                onChanged();
                return this;
              }
              break;
            }
            case 8: {
              bitField0_ |= 0x00000001;
              success_ = input.readBool();
              break;
            }
          }
        }
      }
      
      private int bitField0_;
      
      // required bool success = 1;
      private boolean success_ ;
      public boolean hasSuccess() {
        return ((bitField0_ & 0x00000001) == 0x00000001);
      }
      public boolean getSuccess() {
        return success_;
      }
      public Builder setSuccess(boolean value) {
        bitField0_ |= 0x00000001;
        success_ = value;
        onChanged();
        return this;
      }
      public Builder clearSuccess() {
        bitField0_ = (bitField0_ & ~0x00000001);
        success_ = false;
        onChanged();
        return this;
      }
      
      // @@protoc_insertion_point(builder_scope:protobuf.SSPKG_LOGIN_ACK)
    }
    
    static {
      defaultInstance = new SSPKG_LOGIN_ACK(true);
      defaultInstance.initFields();
    }
    
    // @@protoc_insertion_point(class_scope:protobuf.SSPKG_LOGIN_ACK)
  }
  
  private static com.google.protobuf.Descriptors.Descriptor
    internal_static_protobuf_SSPKG_LOGIN_REQ_descriptor;
  private static
    com.google.protobuf.GeneratedMessage.FieldAccessorTable
      internal_static_protobuf_SSPKG_LOGIN_REQ_fieldAccessorTable;
  private static com.google.protobuf.Descriptors.Descriptor
    internal_static_protobuf_SSPKG_LOGIN_ACK_descriptor;
  private static
    com.google.protobuf.GeneratedMessage.FieldAccessorTable
      internal_static_protobuf_SSPKG_LOGIN_ACK_fieldAccessorTable;
  
  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\021GobangProto.proto\022\010protobuf\"4\n\017SSPKG_L" +
      "OGIN_REQ\022\017\n\007account\030\001 \002(\t\022\020\n\010password\030\002 " +
      "\002(\t\"\"\n\017SSPKG_LOGIN_ACK\022\017\n\007success\030\001 \002(\010"
    };
    com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner assigner =
      new com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner() {
        public com.google.protobuf.ExtensionRegistry assignDescriptors(
            com.google.protobuf.Descriptors.FileDescriptor root) {
          descriptor = root;
          internal_static_protobuf_SSPKG_LOGIN_REQ_descriptor =
            getDescriptor().getMessageTypes().get(0);
          internal_static_protobuf_SSPKG_LOGIN_REQ_fieldAccessorTable = new
            com.google.protobuf.GeneratedMessage.FieldAccessorTable(
              internal_static_protobuf_SSPKG_LOGIN_REQ_descriptor,
              new java.lang.String[] { "Account", "Password", },
              protobuf.GobangProto.SSPKG_LOGIN_REQ.class,
              protobuf.GobangProto.SSPKG_LOGIN_REQ.Builder.class);
          internal_static_protobuf_SSPKG_LOGIN_ACK_descriptor =
            getDescriptor().getMessageTypes().get(1);
          internal_static_protobuf_SSPKG_LOGIN_ACK_fieldAccessorTable = new
            com.google.protobuf.GeneratedMessage.FieldAccessorTable(
              internal_static_protobuf_SSPKG_LOGIN_ACK_descriptor,
              new java.lang.String[] { "Success", },
              protobuf.GobangProto.SSPKG_LOGIN_ACK.class,
              protobuf.GobangProto.SSPKG_LOGIN_ACK.Builder.class);
          return null;
        }
      };
    com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
        }, assigner);
  }
  
  // @@protoc_insertion_point(outer_class_scope)
}