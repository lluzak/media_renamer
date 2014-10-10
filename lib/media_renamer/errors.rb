module MediaRenamer
  Error                 = Class.new(StandardError)
  UnknownMediaTypeError = Class.new(Error)
  SourceNotExistError   = Class.new(Error)
end
