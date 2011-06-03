# namespace for dynamically gnerated schema classes
module Quickbooks::QBXML; end
module Quickbooks::QBPOSXML; end

module Quickbooks::Support
  include Quickbooks

  API_ROOT = File.join(File.dirname(__FILE__), '..', '..').freeze
  XML_SCHEMA_PATH = File.join(API_ROOT, 'xml_schema').freeze   
  RUBY_SCHEMA_PATH = File.join(API_ROOT, 'ruby_schema').freeze 

  SCHEMA_MAP = {
    :qb    => {:dtd_file => "qbxmlops70.xml", 
               :namespace => QBXML, 
               :container_class => lambda { Quickbooks::QBXML::QBXML },
               :magic_hash_key => :qbxml}.freeze,
    :qbpos => {:dtd_file => "qbposxmlops30.xml", 
               :namespace => QBPOSXML, 
               :container_class => lambda { Quickbooks::QBPOSXML::QBPOSXML },
               :magic_hash_key => :qbposxml}.freeze,
  }.freeze

  DEFAULT_LOG_LEVEL = 1

private

  def valid_schema_types
    SCHEMA_MAP.keys
  end

  def valid_schema_type?
    SCHEMA_MAP.include?(schema_type)
  end

  def get_dtd_file
    "#{XML_SCHEMA_PATH}/#{SCHEMA_MAP[schema_type][:dtd_file]}" 
  end

  def get_schema_namespace
    SCHEMA_MAP[schema_type][:namespace]
  end

  def get_container_class
    SCHEMA_MAP[schema_type][:container_class].call
  end

  def get_magic_hash_key
    SCHEMA_MAP[schema_type][:magic_hash_key]
  end
  
  def get_disk_cache_path
    "#{RUBY_SCHEMA_PATH}/#{schema_type.to_s}"
  end

  # fetches all the dynamically generated schema classes
  def cached_classes
    cached_classes = SCHEMA_MAP.inject({}) do |h, (schema_type, opts)|
      namespace = opts[:namespace]
      h[schema_type] = namespace.constants.map { |klass| namespace.const_get(klass) }; h
    end
    cached_classes[schema_type]
  end

  def is_cached_class?(klass)
    SCHEMA_MAP.any? do |schema_type, opts|
      namespace = opts[:namespace]
      namespace.constants.include?(simple_class_name(klass))
    end
  end

  def log
    Quickbooks::API.log
  end

end


