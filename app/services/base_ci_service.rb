class BaseCiService
  attr_reader :connection, :server_url, :auth_key, :project_name

  def initialize(options = {})
    @server_url = options[:server_url]
    @auth_key = options[:auth_key]
    @project_name = options[:project_name]

    @connection = Faraday.new(:url => @server_url) do |faraday|
      faraday.response :json, :content_type => /\bjson$/
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.for_widget(widget)
    new widget.configuration.symbolize_keys
  end

  # Overridden methods

  def repo_info(repository=@project_name, path='', options={})
  end

  def build_info(build_id, repository=@project_name)
  end

  def build_history(repository=@project_name, limit=5)
  end
end
